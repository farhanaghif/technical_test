// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';

import 'package:risa_reborn/model/p3k_model/p3k.dart';
import 'package:risa_reborn/model/p3k_model/type_p3k.dart';

import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_form_tambah.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_informasi.dart';

class P3Klist extends StatefulWidget {
  const P3Klist({Key? key}) : super(key: key);

  @override
  State<P3Klist> createState() => _P3KlistState();
}

class _P3KlistState extends State<P3Klist> {
  List<P3KTipeModel> listTipeP3K = [];
  List<P3KModel> listP3KperTipe = [];
  String? pesan = 'pesan';
  int? selected = 0;

  @override
  void initState() {
    super.initState();
    initP3KList();
    getTipeP3K();
  }

  initP3KList() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get('$baseUrl/api/p3k/getP3K',
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listP3KperTipe.clear();
      List listP3KperTipeAPI = response.data['data'];
      setState(() {
        for (var e in listP3KperTipeAPI) {
          listP3KperTipe.add(P3KModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getTipeP3K() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get("$baseUrl/api/typep3k/getTypeP3K",
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listTipeP3K.clear();
      List listTipeP3KAPI = response.data['data'];
      setState(() {
        for (var e in listTipeP3KAPI) {
          listTipeP3K.add(P3KTipeModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getP3KList(urlKodeTipeP3K) async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get(baseUrl + urlKodeTipeP3K,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listP3KperTipe.clear();
      List listP3KperTipeAPI = response.data['data'];
      pesan = listP3KperTipeAPI.toString();
      setState(() {
        for (var e in listP3KperTipeAPI) {
          listP3KperTipe.add(P3KModel.fromJson(e));
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
            Get.off(const P3KFormTambah());
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
                  text: "Tambah Barang P3K",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ])),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
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
        title: const Text('Inventory Barang P3K'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listTipeP3K.length,
                itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      selectedColor: Colors.blue,
                      label: Text(listTipeP3K[index].nmTypeP3k.toString()),
                      selected: selected == listTipeP3K[index].kdTypeP3k,
                      onSelected: (bool value) {
                        String? urlGetP3K;
                        if (listTipeP3K[index].kdTypeP3k == 0) {
                          urlGetP3K = '/api/p3k/getP3K';
                        }
                        if (listTipeP3K[index].kdTypeP3k != 0) {
                          urlGetP3K =
                              '/api/p3k/getP3KperType/${listTipeP3K[index].kdTypeP3k}';
                        }
                        getP3KList(urlGetP3K.toString());
                        setState(() {
                          selected = listTipeP3K[index].kdTypeP3k!;
                        });
                      },
                    )),
              ),
            ),
          ),
          // Text(listP3KperTipe.toList().toString())
          Flexible(
            child: ListView.builder(
                itemCount: listP3KperTipe.length,
                itemBuilder: (contex, parameter) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        var listDetailP3K = listP3KperTipe[parameter];
                        Get.off(P3K(detailP3K: listDetailP3K));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listP3KperTipe[parameter].nmP3k.toString(),
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  listP3KperTipe[parameter]
                                      .nmTypeP3k
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  listP3KperTipe[parameter]
                                      .nmFasilitasPelabuhan
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
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
