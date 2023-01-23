import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/maintenance/bulanan.dart';
import 'package:risa_reborn/screen/maintenance/triwulan.dart';

class PeriodeMaintenance extends StatelessWidget {
  const PeriodeMaintenance({Key? key}) : super(key: key);

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
            title: const Text('Maintenance'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Bulanan",
                ),
                Tab(
                  text: "Triwulan",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Bulanan(),
              Triwulan(),
            ],
          ),
        ),
      ),
    );
  }
}
