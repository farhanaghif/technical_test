// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apd_model/apd_model.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_form_tambah.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_informasi.dart';

class APDList extends StatefulWidget {
  const APDList({Key? key}) : super(key: key);

  @override
  State<APDList> createState() => _APDListState();
}

class _APDListState extends State<APDList> {
  List<APDModel> listAPDperTipe = [];

  @override
  void initState() {
    super.initState();
    initAPDList();
  }

  initAPDList() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      response = await Dio().get('$baseUrl/api/apd/getAPD',
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listAPDperTipe.clear();
      List listAPDperTipeAPI = response.data['data'];
      setState(() {
        for (var e in listAPDperTipeAPI) {
          listAPDperTipe.add(APDModel.fromJson(e));
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
            Get.off(const APDFormTambah());
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
                  text: "Tambah Barang APD",
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
        title: const Text('Inventory Barang APD'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: listAPDperTipe.length,
                itemBuilder: (contex, parameter) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        var listDetailAPD = listAPDperTipe[parameter];
                        Get.off(BarangAPD(detailAPD: listDetailAPD));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listAPDperTipe[parameter].nmApd.toString(),
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  listAPDperTipe[parameter]
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
                                  "Expired : " +
                                      listAPDperTipe[parameter]
                                          .tglAkhirMasaberlaku
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
