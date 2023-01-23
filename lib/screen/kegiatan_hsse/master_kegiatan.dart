import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KegiatanHSSE extends StatefulWidget {
  const KegiatanHSSE({Key? key}) : super(key: key);

  @override
  _KegiatanHSSEState createState() => _KegiatanHSSEState();
}

class _KegiatanHSSEState extends State<KegiatanHSSE> {
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
        title: const Text('Cheklist'),
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const AparList()));
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
                                  child: Icon(Icons.anchor_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Safety Patrol',
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
                        //     builder: (context) => const AparList()));
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
                                  child: Icon(Icons.verified_user_outlined,
                                      size: 50, color: Colors.blue),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: const Text(
                                  'Security Patrol',
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
                        //     builder: (context) => const AparList()));
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
                                  'Sacurity Patrol',
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
                        //     builder: (context) => const AparList()));
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
                                  'Pelayanan PBK',
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
                                  'Insiden/Kecelakaan',
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
