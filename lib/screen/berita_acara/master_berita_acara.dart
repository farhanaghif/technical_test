import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/perangkat/lokasi/lokasi_form.dart';
import 'package:risa_reborn/screen/perangkat/jenis/jenis_form.dart';

class BeritaAcara extends StatefulWidget {
  const BeritaAcara({Key? key}) : super(key: key);

  @override
  State<BeritaAcara> createState() => _BeritaAcaraState();
}

class _BeritaAcaraState extends State<BeritaAcara> {
  final List bulan = [
    "Januari",
    "Fabruari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            // actions: [
            //   IconButton(
            //     icon: const Icon(
            //       Icons.search,
            //       size: 28,
            //     ),
            //     onPressed: () {},
            //   ),
            //   IconButton(
            //     icon: const Icon(
            //       Icons.arrow_forward,
            //       size: 24,
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => const FormTambahPerangkat()));
            //     },
            //   ),
            // ],
            title: const Text('Berita Acara'),
            // centerTitle: false,
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title:
                      Text(bulan[index], style: const TextStyle(fontSize: 25)),
                  subtitle: Text('ini subtitle dari ' + bulan[index]),
                  onTap: () {
                    // var listDetailPerangkat = listPerangkat[index];
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         PerangkatDetail(listDetailPerangkat),
                    //   ),
                    // );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FormTambahlokasi()));
                  },
                  // subtitle: Text('ini subtitle dari ' + bulan[index]),
                  // leading: CircleAvatar(
                  //   child:
                  //       Text(bulan[index][0], // ambil karakter pertama text
                  //           style: TextStyle(fontSize: 20)),
                  // )
                ),
              );
            },
            itemCount: bulan.length,
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20),
            child: FloatingActionButton(
              // isExtended: true,
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FormTambahJenisPerangkat()));
              },
            ),
          ),
        ),
      );
}
