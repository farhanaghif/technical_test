import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/apar/master_apar.dart';
import 'package:risa_reborn/screen/apar/rusak&expired/apar_rusak.dart';
import 'package:risa_reborn/screen/apar/rusak&expired/apar_rusak_riwayat.dart';

class RusakApar extends StatelessWidget {
  const RusakApar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MasterApar()));
              },
            ),
            title: const Text('Rusak & Expired'),
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
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Semua",
                ),
                Tab(
                  text: "Riwayat",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AparRusak(),
              AparRusakRiwayat(),
            ],
          ),
        ),
      ),
    );
  }
}
