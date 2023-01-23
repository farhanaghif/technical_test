import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class FormCeklistPerangkat extends StatefulWidget {
  const FormCeklistPerangkat({Key? key}) : super(key: key);

  @override
  State<FormCeklistPerangkat> createState() => _FormCeklistPerangkatState();
}

class _FormCeklistPerangkatState extends State<FormCeklistPerangkat> {
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
          // print('back button preses!');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Ceklist'),
          ),
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
