import 'package:flutter/material.dart';

class RiwayatSafetyBreafing extends StatefulWidget {
  const RiwayatSafetyBreafing({Key? key}) : super(key: key);

  @override
  State<RiwayatSafetyBreafing> createState() => _RiwayatSafetyBreafingState();
}

class _RiwayatSafetyBreafingState extends State<RiwayatSafetyBreafing> {
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
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title:
                      Text(bulan[index], style: const TextStyle(fontSize: 25)),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const FormTambahPerangkat()));
                  },
                ),
              );
            },
            itemCount: bulan.length,
          ),
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: FloatingActionButton(
          //     // isExtended: true,
          //     child: Icon(Icons.add),
          //     backgroundColor: Colors.green,
          //     onPressed: () {
          //       // Navigator.of(context).push(MaterialPageRoute(
          //       //     builder: (context) => const FormTambahPerangkat()));
          //     },
          //   ),
          // ),
        ),
      );
}
