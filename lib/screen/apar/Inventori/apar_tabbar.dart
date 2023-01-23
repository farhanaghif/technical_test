import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_detail.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_riwayat.dart';

import '../../../model/apar_model/a_model.dart';

class Apar extends StatelessWidget {
  final AparModel detailApar;
  const Apar({Key? key, required this.detailApar}) : super(key: key);

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
            title: const Text('Detail Apar'),
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
          body: TabBarView(
            children: [
              AparDetail(detailApar),
              const AparRiwayat(),
            ],
          ),
        ),
      ),
    );
  }
}
