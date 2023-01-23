import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_detail.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_riwayat.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_form_keluar.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_form_masuk.dart';

import '../../../model/peralatan_model/peralatan_kerja.dart';

class AlatKerja extends StatelessWidget {
  final PeralatankerjaModel detailAlatKerja;

  const AlatKerja({Key? key, required this.detailAlatKerja}) : super(key: key);

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
                Get.back();
              },
            ),
            title: const Text('Informasi Alat Kerja'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Detail",
                ),
                Tab(
                  text: "Riwayat Pemakaian",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AlatKerjaDetail(detailAlatKerja),
              RiwayatAlatKerja(detailAlatKerja),
            ],
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: const Color.fromARGB(255, 53, 133, 224),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            activeIcon: (Icons.close),
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: const CircleBorder(),
            children: [
              SpeedDialChild(
                  child: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 149, 219, 161),
                  label: 'Tambahkan Stok Alat Kerja',
                  onTap: () => Get.off(FormAlatKerjaMasuk(detailAlatKerja))),
              SpeedDialChild(
                  child: const Icon(
                    Icons.remove_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 231, 166, 217),
                  label: 'Kurangi Stok Alat Kerja',
                  onTap: () => Get.off(FormAlatKerjaKeluar(detailAlatKerja))),
            ],
          ),
        ),
      ),
    );
  }
}
