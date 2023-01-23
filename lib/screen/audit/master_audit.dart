import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/audit/audit_riwayat.dart';
import 'package:risa_reborn/screen/audit/audit_form.dart';

class Audit extends StatelessWidget {
  const Audit({Key? key}) : super(key: key);

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
            title: const Text('Audit'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Temuan",
                ),
                Tab(
                  text: "Riwayat",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FormTemuanAudit(),
              AuditRiwayat(),
            ],
          ),
        ),
      ),
    );
  }
}
