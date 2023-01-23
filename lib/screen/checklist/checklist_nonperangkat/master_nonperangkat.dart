import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/checklist_model/checklist_nonperangkat_model.dart';

class MasterNonPerangkat extends StatefulWidget {
  const MasterNonPerangkat({Key? key}) : super(key: key);

  @override
  State<MasterNonPerangkat> createState() => _MasterNonPerangkatState();
}

class _MasterNonPerangkatState extends State<MasterNonPerangkat> {
  List<ChecklistNonPerangkatModel> listChecklistNonPerangkat = [];

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
      respFasPel = await Dio().get("$baseUrl/api/checklist/getChecklist",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      listChecklistNonPerangkat.clear();
      List checklistNonPerangkatAPI = respFasPel.data['data'];
      setState(() {
        for (var e in checklistNonPerangkatAPI) {
          listChecklistNonPerangkat.add(ChecklistNonPerangkatModel.fromJson(e));
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
      respFasPel = await Dio().get("$baseUrl/api/checklist/getChecklist",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      listChecklistNonPerangkat.clear();
      List checklistNonPerangkatAPI = respFasPel.data['data'];
      setState(() {
        for (var e in checklistNonPerangkatAPI) {
          listChecklistNonPerangkat.add(ChecklistNonPerangkatModel.fromJson(e));
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
        title: const Text('Master Checklist'),
      ),
      body: RefreshIndicator(
          strokeWidth: 5,
          onRefresh: (refreshGetChecklistNonPerangkat),
          child: ListView.builder(
              itemCount: listChecklistNonPerangkat.length,
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
                      leading: (listChecklistNonPerangkat[index].ketChecklist ==
                              'berhasil')
                          ? const Icon(Icons.av_timer)
                          : const Icon(Icons.close),
                      title: Text(listChecklistNonPerangkat[index]
                          .userCreated
                          .toString()),
                      subtitle: Text(listChecklistNonPerangkat[index]
                          .tglUpdated
                          .toString()),
                      trailing: Text(
                          listChecklistNonPerangkat[index].nmShift.toString()),
                    ),
                  ),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 160,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {},
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
                  "Tambah",
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
