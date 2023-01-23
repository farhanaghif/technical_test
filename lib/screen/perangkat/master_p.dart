import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_list.dart';

class MasterMenuPerangkat extends StatefulWidget {
  const MasterMenuPerangkat({Key? key}) : super(key: key);

  @override
  _MasterMenuPerangkatState createState() => _MasterMenuPerangkatState();
}

class _MasterMenuPerangkatState extends State<MasterMenuPerangkat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {},
        ),
        title: const Text('APAR'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color.fromARGB(255, 73, 122, 83),
                Color.fromARGB(255, 73, 122, 83)
              ])),
        ),
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
                                  child: Icon(Icons.bookmark_added_outlined,
                                      size: 50,
                                      color: Color.fromARGB(255, 241, 39, 13)),
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
                                      size: 50,
                                      color: Color.fromARGB(255, 241, 39, 13)),
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
                                      size: 50,
                                      color: Color.fromARGB(255, 241, 39, 13)),
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
