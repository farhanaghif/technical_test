import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apar_model/a_bahan_model.dart';
import 'package:risa_reborn/model/apar_model/a_model.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_form_tambah.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_tabbar.dart';

class AparList extends StatefulWidget {
  const AparList({Key? key}) : super(key: key);

  @override
  State<AparList> createState() => _AparListState();
}

class _AparListState extends State<AparList> {
  List<BahanAparModel> listBahanApar = [];
  List<AparModel> listAPARperBahan = [];
  int? selected = 0;

  @override
  void initState() {
    super.initState();
    initAparList();
    getBahanApar();
  }

  initAparList() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get('$baseUrl/api/apar/getApar',
          options: Options(headers: {
            "Accept": "*/*",
            "Authorization": "Bearer $tokenBaru",
          }));
      listAPARperBahan.clear();
      List listAPARperBahanAPI = response.data['data'];
      setState(() {
        for (var e in listAPARperBahanAPI) {
          listAPARperBahan.add(AparModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getBahanApar() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get("$baseUrl/api/bahanapar/getBahanAparAktif",
          options: Options(headers: {
            "Accept": "*/*",
            "Authorization": "Bearer $tokenBaru",
          }));
      listBahanApar.clear();
      List listBahanAparAPI = response.data['data'];
      setState(() {
        for (var e in listBahanAparAPI) {
          listBahanApar.add(BahanAparModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getAparList(urlKodeBahanApar) async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get(baseUrl + urlKodeBahanApar,
          options: Options(headers: {
            "Accept": "*/*",
            "Authorization": "Bearer $tokenBaru",
          }));
      setState(() {
        listAPARperBahan.clear();
      });
      List listAPARperBahanAPI = response.data['data'];
      setState(() {
        for (var e in listAPARperBahanAPI) {
          listAPARperBahan.add(AparModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 30),
        child: GestureDetector(
          onLongPress: () {},
          onTap: () {
            Get.off(const AparFormTambah());
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(24)),
            child: const Text.rich(TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Icon(
                Icons.add,
                size: 21,
                color: Colors.white,
              )),
              TextSpan(
                  text: "Tambah APAR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ])),
          ),
        ),
      ),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
        title: const Text('Inventory APAR'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listBahanApar.length,
                itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      selectedColor: Colors.blue,
                      label: Text(listBahanApar[index].nmBhnApar.toString()),
                      selected: selected == listBahanApar[index].kdBhnApar,
                      onSelected: (bool value) {
                        String? urlGetApar;
                        if (listBahanApar[index].kdBhnApar == 0) {
                          urlGetApar = '/api/apar/getApar';
                        }
                        if (listBahanApar[index].kdBhnApar != 0) {
                          urlGetApar =
                              '/api/apar/getAparperBahan/${listBahanApar[index].kdBhnApar.toString()}';
                        }
                        getAparList(urlGetApar.toString());
                        setState(() {
                          selected = listBahanApar[index].kdBhnApar as int;
                        });
                      },
                    )),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: listAPARperBahan.length,
                itemBuilder: (contex, parameter) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        var listDetailApar = listAPARperBahan[parameter];
                        Get.off(Apar(detailApar: listDetailApar));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  listAPARperBahan[parameter].nmApar.toString(),
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  listAPARperBahan[parameter]
                                      .nmBhnApar
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  listAPARperBahan[parameter]
                                      .nmFasilitasPelabuhan
                                      .toString(),
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
