import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/checklist_model/checklist_header_model.dart';
import 'package:risa_reborn/model/checklist_model/checklist_nonperangkat_model.dart';
import 'package:risa_reborn/screen/checklist/checklist_nonperangkat/master_nonperangkat.dart';

class ChecklistNonPerangkat extends StatefulWidget {
  const ChecklistNonPerangkat({Key? key}) : super(key: key);

  @override
  State<ChecklistNonPerangkat> createState() => _ChecklistNonPerangkatState();
}

class _ChecklistNonPerangkatState extends State<ChecklistNonPerangkat> {
  List<ChecklistNonPerangkatModel> listChecklistNonPerangkat = [];
  List<ChecklistHeaderNonPerangkatModel> listChecklistHeaderNonPerangkat = [];
  List iniShift = [
    'Shift 1',
    'Shift 2',
    'Shift 3',
  ];
  List iniShiftAngka = [1, 2, 3];
  int? selected = 0;

  @override
  void initState() {
    super.initState();
    getChecklistNonPerangkat();
  }

  Future<void> refreshGetChecklistNonPerangkat() async {
    Response respFasPel;
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respFasPel = await Dio().get("$baseUrl/api/checklist/getChecklistHeader",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      listChecklistHeaderNonPerangkat.clear();
      List checklistNonPerangkatAPI = respFasPel.data['data'];
      setState(() {
        for (var e in checklistNonPerangkatAPI) {
          listChecklistHeaderNonPerangkat
              .add(ChecklistHeaderNonPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getChecklistNonPerangkat() async {
    Response respFasPel;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respFasPel = await Dio().get("$baseUrl/api/checklist/getChecklistHeader",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      listChecklistHeaderNonPerangkat.clear();
      List checklistNonPerangkatAPI = respFasPel.data['data'];
      setState(() {
        for (var e in checklistNonPerangkatAPI) {
          listChecklistHeaderNonPerangkat
              .add(ChecklistHeaderNonPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist Non-Perangkat'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const MasterNonPerangkat());
              },
              icon: const Icon(
                Icons.list_alt,
                size: 28,
              )),
        ],
      ),
      body: RefreshIndicator(
          strokeWidth: 5,
          onRefresh: refreshGetChecklistNonPerangkat,
          child: ListView.builder(
              itemCount: listChecklistHeaderNonPerangkat.length,
              itemBuilder: (contex, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.only(bottom: 5, right: 10, left: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {},
                      leading:
                          (listChecklistHeaderNonPerangkat[index].nmShift ==
                                  'Shift 1')
                              ? const Icon(Icons.check)
                              : const Icon(Icons.close),
                      title: Text(listChecklistHeaderNonPerangkat[index]
                          .userCreated
                          .toString()),
                      subtitle: Text(listChecklistHeaderNonPerangkat[index]
                          .tglUpdated
                          .toString()),
                      trailing: Text(listChecklistHeaderNonPerangkat[index]
                          .nmShift
                          .toString()),
                    ),
                  ),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 160,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              Get.bottomSheet(
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      height: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            indent: 80,
                            endIndent: 80,
                            height: 10,
                            thickness: 5,
                            color: Colors.grey,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 45,
                                ),
                                const Text(
                                  "Membuat data checklist",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                // * Pilih kategori text ------------------------
                                const Text(
                                  "Pilih shift :",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: iniShift.length,
                                      itemBuilder: ((context, index) =>
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              child: ChoiceChip(
                                                selectedColor: Colors.blue,
                                                label: Text(iniShift[index]),
                                                selected: selected ==
                                                    iniShiftAngka[index],
                                                onSelected: (bool value) {
                                                  setState(() {
                                                    selected =
                                                        iniShiftAngka[index]
                                                            as int;
                                                  });
                                                },
                                              )))),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          primary: const Color.fromARGB(
                                              255, 30, 156, 230),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.add),
                                            Text('Generate Check'),
                                          ],
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Buat Check",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
