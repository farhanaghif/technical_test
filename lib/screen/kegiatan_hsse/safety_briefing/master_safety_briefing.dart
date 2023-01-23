import 'package:flutter/material.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/safety_briefing/safety_briefing_form.dart';
import 'package:risa_reborn/screen/kegiatan_hsse/safety_briefing/safety_briefing_riwayat.dart';

class SafetyBreafing extends StatelessWidget {
  const SafetyBreafing({Key? key}) : super(key: key);

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
            title: const Text('Safety Breafing'),
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
              FormTambahSafetyBreafing(),
              RiwayatSafetyBreafing(),
            ],
          ),
        ),
      ),
    );
  }
}
