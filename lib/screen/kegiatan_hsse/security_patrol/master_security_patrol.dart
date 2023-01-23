import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/safety_patrol/safety_patrol_riwayat.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/security_patrol/security_patrol_form.dart';

class SecurityPatrol extends StatelessWidget {
  const SecurityPatrol({Key? key}) : super(key: key);

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
            title: const Text('Security Patrol'),
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
              FormTambahKegiatanSecurityPatrol(),
              RiwayatSecurityPatrol(),
            ],
          ),
        ),
      ),
    );
  }
}
