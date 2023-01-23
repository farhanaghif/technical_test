import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_detail.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_form_keluar.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_form_masuk.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_riwayat.dart';

import '../../../model/apd_model/apd_model.dart';

class BarangAPD extends StatelessWidget {
  final APDModel detailAPD;
  const BarangAPD({Key? key, required this.detailAPD}) : super(key: key);

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
            title: const Text('Informasi Barang APD'),
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
              APDDetail(detailAPD),
              RiwayatBarangAPD(detailAPD),
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
                  label: 'Tambahkan Stok Barang APD',
                  onTap: () => Get.off(FormBarangAPDMasuk(detailAPD))),
              SpeedDialChild(
                  child: const Icon(
                    Icons.remove_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 231, 166, 217),
                  label: 'Kurangi Stok Barang APD',
                  onTap: () => Get.off(FormBarangAPDKeluar(detailAPD))),
            ],
          ),
        ),
      ),
    );
  }
}
