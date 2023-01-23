import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/perangkat_model/p_jenis_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_model.dart';
import 'package:risa_reborn/screen/perangkat/master_perangkat/perangkat_detail.dart';
import 'package:risa_reborn/screen/perangkat/master_perangkat/perangkat_form_tambah.dart';
import 'package:dio/dio.dart';

class ListPerangkat extends StatefulWidget {
  @required
  final JenisPerangkatModel perangkat;
  const ListPerangkat(this.perangkat, {Key? key}) : super(key: key);

  @override
  State<ListPerangkat> createState() => _ListPerangkatState();
}

class _ListPerangkatState extends State<ListPerangkat> {
  List<PerangkatModel> listPerangkat = [];

  @override
  void initState() {
    super.initState();
    getAPIPerangkat();
  }

  getAPIPerangkat() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    try {
      var urlbuatAPI =
          "$baseUrl/api/perangkat/getPerangkatperJenis/${widget.perangkat.urlJenisPerangkat}";
      response = await Dio().get(urlbuatAPI,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listPerangkat.clear();
      List listPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in listPerangkatAPI) {
          listPerangkat.add(PerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 30),
            child: GestureDetector(
              onLongPress: () {},
              onTap: () {
                Get.off(FormTambahPerangkat(widget.perangkat));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24)),
                child: const Text.rich(TextSpan(children: <InlineSpan>[
                  WidgetSpan(
                      child: Icon(
                    Icons.add,
                    size: 21,
                    color: Colors.white,
                  )),
                  TextSpan(
                      text: "Tambah Perangkat",
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
            title: Text('List Perangkat ${widget.perangkat.nmJenisPerangkat}'),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    onTap: () {
                      Get.off(PerangkatDetail(listPerangkat[index]));
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listPerangkat[index].nmPerangkat.toString(),
                                style: const TextStyle(fontSize: 16)),
                            Text(
                              listPerangkat[index].nmMerkPerangkat.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              listPerangkat[index].nmLokasi.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                          listPerangkat[index]
                              .nmMerkPerangkat
                              .toString()[0], // ambil karakter pertama text
                          style: const TextStyle(fontSize: 20)),
                    )),
              );
            },
            itemCount: listPerangkat.length,
          ),
        ),
      );
}
