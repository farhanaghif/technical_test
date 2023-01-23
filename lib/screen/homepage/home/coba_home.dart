import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/router/app_routes.dart';
import 'package:risa_reborn/const.dart';

// ignore: must_be_immutable
class CobaHome extends StatelessWidget {
  CobaHome({Key? key}) : super(key: key);
  List menu = [
    "Perangkat",
    "Stock",
    "APAR",
    "Barang P3K",
    "Barang APD",
    "Peralatan Kerja",
    "Checklist",
    "Logout"
  ];
  List menuOnTap = [
    AppRoute.perangkat,
    AppRoute.stock,
    AppRoute.apar,
    AppRoute.barangP3k,
    AppRoute.barangApd,
    AppRoute.peralatanKerja,
    AppRoute.checklistPerangkat,
    AppRoute.login,
  ];
  List iconMenu = [
    Icons.devices,
    Icons.inventory,
    Icons.fire_extinguisher_sharp,
    Icons.safety_divider,
    Icons.shield_outlined,
    Icons.work,
    Icons.checklist_sharp,
    Icons.logout
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 92, 178, 228),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: menuOnTap.length,
          itemBuilder: (context, index) {
            return GridTile(
                child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (menuOnTap[index] != AppRoute.login) {
                              Get.toNamed(menuOnTap[index]);
                            } else {
                              dataStorage.deleteAll();
                              Get.offAndToNamed(menuOnTap[index]);
                            }
                          },
                          icon: Icon(iconMenu[index])),
                      // Icon(iconMenu[index]),
                      Text(menu[index]),
                    ],
                  ),
                ),
              ),
            ));
          }),
    );
  }
}
