import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/insiden/insiden_detail.dart';
import 'package:risa_reborn/screen/insiden/pending_insiden.dart';
import 'package:risa_reborn/screen/insiden/proses_insiden.dart';
import 'package:risa_reborn/screen/insiden/selesai_insiden.dart';

class Insiden extends StatelessWidget {
  const Insiden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Insiden'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Semua",
                ),
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Proses",
                ),
                Tab(
                  text: "Selesai",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SemuaInsiden(),
              PendingInsiden(),
              ProsesInsiden(),
              SelesaiInsiden()
            ],
          ),
        ),
      ),
    );
  }
}
