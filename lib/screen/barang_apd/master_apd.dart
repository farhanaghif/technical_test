import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_list.dart';

class MasterAPD extends StatefulWidget {
  const MasterAPD({Key? key}) : super(key: key);

  @override
  _MasterAPDState createState() => _MasterAPDState();
}

class _MasterAPDState extends State<MasterAPD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Barang APD'),
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
                        Get.to(const APDList());
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
                                  child: Icon(Icons.local_hospital_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Inventory Barang APD',
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
                      onTap: () {},
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
                                  child: Icon(Icons.date_range_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Checklist Barang APD',
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
                      onTap: () {},
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
                                  child: Icon(Icons.category_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Item dan Jumlah Barang APD',
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
