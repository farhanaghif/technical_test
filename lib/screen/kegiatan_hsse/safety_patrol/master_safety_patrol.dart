import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/safety_patrol/safety_patrol_form.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/safety_patrol/safety_patrol_riwayat.dart';

class SafetyPatrol extends StatelessWidget {
  const SafetyPatrol({Key? key}) : super(key: key);

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
            title: const Text('Safety Patrol'),
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
              FormTambahSafetyPatrol(),
              RiwayatSecurityPatrol(),
            ],
          ),
        ),
      ),
    );
  }
}
