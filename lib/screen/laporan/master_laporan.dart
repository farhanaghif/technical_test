import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/screen/perangkat/lokasi/lokasi_form.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  final List bulan = [
    "Januari",
    "Fabruari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Laporan'),
            // centerTitle: false,
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title:
                      Text(bulan[index], style: const TextStyle(fontSize: 25)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FormTambahlokasi()));
                  },
                ),
              );
            },
            itemCount: bulan.length,
          ),
          // floatingActionButton: SpeedDial(
          //   backgroundColor: Color.fromARGB(255, 53, 133, 224),
          //   animatedIcon: AnimatedIcons.menu_close,
          //   animatedIconTheme: IconThemeData(size: 22.0),
          //   child: Icon(Icons.add),
          //   curve: Curves.bounceIn,
          //   overlayColor: Colors.black,
          //   overlayOpacity: 0.5,
          //   onOpen: () => print('OPENING DIAL'),
          //   onClose: () => print('DIAL CLOSED'),
          //   tooltip: 'Speed Dial',
          //   heroTag: 'speed-dial-hero-tag',
          //   foregroundColor: Colors.black,
          //   elevation: 8.0,
          //   shape: const CircleBorder(),
          //   children: [
          //     SpeedDialChild(
          //         child: const Icon(Icons.add_outlined),
          //         backgroundColor: const Color.fromARGB(255, 231, 166, 217),
          //         label: 'Tambahkan Stok',
          //         onTap: () => print('FIRST CHILD')),
          //     SpeedDialChild(
          //         child: const Icon(Icons.remove_outlined),
          //         backgroundColor: const Color.fromARGB(255, 149, 219, 161),
          //         label: 'Kurangi Stok',
          //         onTap: () => print('FIRST CHILD')),
          //   ],
          // ),
          floatingActionButton: SpeedDial(
            renderOverlay: true,
            useRotationAnimation: true,
            // animationSpeed: 5,
            curve: Curves.bounceInOut,
            overlayColor: Colors.grey[100],
            // buttonSize: 60.0,
            visible: true,
            icon: Icons.add,
            backgroundColor: const Color.fromARGB(255, 49, 155, 187),
            foregroundColor: Colors.black,
            elevation: 5.0,
            shape: const CircleBorder(),
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add_outlined),
                backgroundColor: Colors.green[300],
                label: 'Money',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () {
                  // _newDonationPopUp(context, size, true);
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return NewDonationsScreen(isMoney: true);
                  // }));
                },
                onLongPress: () {},
              ),
              SpeedDialChild(
                child: const Icon(
                  Icons.remove_outlined,
                ),
                backgroundColor: Colors.blue[300],
                label: 'Item',
                labelStyle: const TextStyle(fontSize: 18.0),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return NewDonationsScreen(isMoney: false);
                  // }));
                },
                onLongPress: () {},
              ),
            ],
          ),
        ),
      );
}
