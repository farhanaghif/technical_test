import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:risa_reborn/const.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/model/perangkat_model/p_role_model.dart';
import 'package:risa_reborn/screen/homepage/home/coba_home.dart';
import 'package:risa_reborn/screen/login/background.dart';
import 'package:risa_reborn/service/remote_service/login_service.dart';

// ignore: must_be_immutable
class PilihRole extends StatelessWidget {
  PilihRole({Key? key}) : super(key: key);
  final dataUser = <UserModel>[].obs;

  void prosesLogin(int index) async {
    var username = await dataStorage.read(key: 'username');
    var token = await dataStorage.read(key: 'token');
    LoginService()
        .postProsesLogin(
            '$baseUrl/api/auth/proses_login',
            json.encode(
                {'username': username, 'kd_role': dataUser[index].kdRole}),
            token)
        .then((value) async {
      if (value.statusCode == 200) {
        await dataStorage.write(
            key: 'token_baru', value: value.body['access_token']);
        Get.snackbar('SUCCESS', value.body['pesan'],
            backgroundColor: Colors.green.shade300,
            icon: const Icon(Icons.check_circle_outline));
        Get.off(CobaHome());
      } else if (value.statusCode == 400) {
        Get.snackbar(value.body['pesan'], 'Silahkan coba lagi',
            backgroundColor: Colors.red.shade300,
            icon: const Icon(Icons.warning_amber_sharp));
      } else if (value.statusCode != 200 && value.statusCode != 400) {
        Get.snackbar(
            'Server sedang dalam perbaikan', 'Mohon hubungi koordinator cabang',
            backgroundColor: Colors.red.shade300,
            icon: const Icon(Icons.warning_amber_sharp));
      }
    });
  }

  getPilihRole() async {
    if (dataUser.isEmpty) {
      var token = await dataStorage.read(key: 'token');
      LoginService()
          .getAPI(token, '$baseUrl/api/auth/pilih_role')
          .then((value) {
        for (var e in value.body['data']) {
          dataUser.add(UserModel.fromJson(e));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: const Text(
                    "Pilih Role",
                    style: TextStyle(
                      color: Color.fromARGB(255, 21, 141, 211),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      getPilihRole();
                      return Container(
                          height: 300,
                          width: 300,
                          margin: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: dataUser.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  itemCount: dataUser.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: ListTile(
                                            textColor: Colors.blue,
                                            onTap: () {
                                              prosesLogin(index);
                                            },
                                            title: Center(
                                                child: Text(
                                                    dataUser[index].nmRole))),
                                      ),
                                    );
                                  },
                                ));
                    }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
