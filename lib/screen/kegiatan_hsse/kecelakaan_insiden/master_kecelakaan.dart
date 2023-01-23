import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/kecelakaan_insiden/kecelakaan_form.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/kecelakaan_insiden/kecelakaan_riwayat.dart';

class KecelakaanHSSE extends StatelessWidget {
  const KecelakaanHSSE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {},
            ),
            title: const Text('Kecelakaan & Insiden'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Kasus",
                ),
                Tab(
                  text: "Riwayat",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FormTambahKecelakaanHSE(),
              RiwayatKecelakaanHSE(),
            ],
          ),
        ),
      ),
    );
  }
}
