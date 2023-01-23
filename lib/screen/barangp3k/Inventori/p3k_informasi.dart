import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_detail.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_form_keluar.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_form_masuk.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_pemakaian.dart';

import '../../../model/p3k_model/p3k.dart';

class P3K extends StatelessWidget {
  final P3KModel detailP3K;
  const P3K({Key? key, required this.detailP3K}) : super(key: key);

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
            title: const Text('Informasi Barang P3K'),
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
              P3KDetail(detailP3K),
              PemakaianP3K(detailP3K),
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
                  label: 'Tambahkan Stok Barang P3K',
                  onTap: () => Get.off(FormMasukP3K(detailP3K))),
              SpeedDialChild(
                  child: const Icon(
                    Icons.remove_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 231, 166, 217),
                  label: 'Kurangi Stok Barang P3K',
                  onTap: () => Get.off(FormKeluarP3K(detailP3K))),
            ],
          ),
        ),
      ),
    );
  }
}
