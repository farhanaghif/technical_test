// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/peralatan_model/peralatan_kerja.dart';

import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_form_tambah.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_informasi.dart';

class AlatKerjaList extends StatefulWidget {
  const AlatKerjaList({Key? key}) : super(key: key);

  @override
  State<AlatKerjaList> createState() => _AlatKerjaListState();
}

class _AlatKerjaListState extends State<AlatKerjaList> {
  List<PeralatankerjaModel> listAlatKerjaperTipe = [];

  @override
  void initState() {
    super.initState();
    initAlatKerjaList();
  }

  initAlatKerjaList() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response =
          await Dio().get('$baseUrl/api/peralatankerja/getPeralatanKerja',
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));
      listAlatKerjaperTipe.clear();
      List listAlatKerjaperTipeAPI = response.data['data'];
      setState(() {
        for (var e in listAlatKerjaperTipeAPI) {
          listAlatKerjaperTipe.add(PeralatankerjaModel.fromJson(e));
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
            Get.off(const AlatKerjaFormTambah());
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
                  text: "Tambah Alat Kerja",
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
        title: const Text('Inventory Alat Kerja'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: listAlatKerjaperTipe.length,
                itemBuilder: (contex, parameter) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        var listDetailAlatKerja =
                            listAlatKerjaperTipe[parameter];
                        Get.off(
                            AlatKerja(detailAlatKerja: listDetailAlatKerja));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  listAlatKerjaperTipe[parameter]
                                      .nmPeralatanKerja
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  listAlatKerjaperTipe[parameter]
                                      .nmKondisiPerangkat
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "Tanggal Beli : " +
                                      listAlatKerjaperTipe[parameter]
                                          .tglPembelian
                                          .toString(),
                                  style: const TextStyle(fontSize: 14)),
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
