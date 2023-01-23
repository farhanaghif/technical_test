import 'package:flutter/material.dart';

class Bulanan extends StatefulWidget {
  const Bulanan({Key? key}) : super(key: key);

  @override
  State<Bulanan> createState() => _BulananState();
}

class _BulananState extends State<Bulanan> {
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
                  leading: CircleAvatar(
                    child: Text(bulan[index][0], // ambil karakter pertama text
                        style: const TextStyle(fontSize: 20)),
                  ),
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
