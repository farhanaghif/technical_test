import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/checklist_model/checklist_nonperangkat_model.dart';

class ChecklistPerangkat extends StatefulWidget {
  const ChecklistPerangkat({Key? key}) : super(key: key);

  @override
  State<ChecklistPerangkat> createState() => _ChecklistPerangkatState();
}

class _ChecklistPerangkatState extends State<ChecklistPerangkat> {
  List<ChecklistNonPerangkatModel> listChecklistNonPerangkat = [];

  @override
  void initState() {
    super.initState();
    getChecklistPerangkat();
  }

  Future<void> refreshGetChecklistPerangkat() async {
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

  Future<void> getChecklistPerangkat() async {
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
        title: const Text('Checklist Perangkat'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.list_alt,
                size: 28,
              )),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: refreshGetChecklistPerangkat,
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
                      leading: const Icon(Icons.av_timer),
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
