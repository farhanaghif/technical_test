import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/pelayanan_pbk/pelayanan_pbk_form.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/pelayanan_pbk/pelayanan_pbk_riwayat.dart';

class PelayananPBK extends StatelessWidget {
  const PelayananPBK({Key? key}) : super(key: key);

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
            title: const Text('Pelayanan PBK'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Kegiatan",
                ),
                Tab(
                  text: "Riwayat",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FormTambahPelayananPBK(),
              RiwayatPelayananPBK(),
            ],
          ),
        ),
      ),
    );
  }
}
