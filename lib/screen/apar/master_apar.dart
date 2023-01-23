import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_list.dart';
// ignore: unused_import
import 'package:risa_reborn/screen/apar/Inventori/apar_tabbar.dart';

class MasterApar extends StatefulWidget {
  const MasterApar({Key? key}) : super(key: key);

  @override
  _MasterAparState createState() => _MasterAparState();
}

class _MasterAparState extends State<MasterApar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const PerangkatDetail()));
            },
          ),
        ],
        title: const Text('APAR'),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AparList()));
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
                                  child: Icon(Icons.inventory_2_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Inventory APAR',
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Apar()));
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
                                  child: Icon(Icons.center_focus_strong,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Checklist APAR',
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Apar()));
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
                                  'Rusak & Expired',
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
