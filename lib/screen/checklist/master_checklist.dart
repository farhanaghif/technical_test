import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/checklist/checklist_nonperangkat/check_nonperangkat.dart';
import 'package:risa_reborn/screen/checklist/checklist_perangkat/check_perangkat.dart';

class MasterChechklist extends StatefulWidget {
  const MasterChechklist({Key? key}) : super(key: key);

  @override
  _MasterChechklistState createState() => _MasterChechklistState();
}

class _MasterChechklistState extends State<MasterChechklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Checklist'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTap: () {
                        Get.to(const ChecklistPerangkat());
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Center(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                elevation: 5,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.phonelink_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Cheklist Perangkat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTap: () {
                        Get.to(const ChecklistNonPerangkat());
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Center(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                elevation: 5,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.people_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Checklist Non Perangkat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }
}
