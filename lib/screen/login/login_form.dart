import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/router/app_routes.dart';
import 'package:risa_reborn/screen/login/background.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/service/remote_service/login_service.dart';

// ignore: must_be_immutable
class FormLogin extends StatelessWidget {
  FormLogin({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var obscureText = true.obs;
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const Background(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Image.asset(
                        'assets/images/icon_risa.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 40),
                      Container(
                        margin: const EdgeInsets.only(bottom: 60),
                        child: const Text(
                          "Risa Reborn",
                          style: TextStyle(
                            color: Color.fromARGB(255, 21, 141, 211),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 220,
                          width: 1500,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 32),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    border: InputBorder.none,
                                    prefixIcon:
                                        Icon(Icons.account_circle_rounded),
                                    labelText: "Masukkan Username",
                                  ),
                                  controller: usernameController,
                                ),
                              ),
                              Obx(() => Container(
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 32),
                                    child: TextFormField(
                                      obscureText: obscureText.value,
                                      decoration: InputDecoration(
                                          hintStyle:
                                              const TextStyle(fontSize: 15),
                                          border: InputBorder.none,
                                          labelText: "Masukkan Password",
                                          prefixIcon: const Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                obscureText.value =
                                                    !obscureText.value;
                                              },
                                              icon: obscureText.value
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility))),
                                      controller: passwordController,
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              Obx(() => SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color.fromARGB(
                                                  255, 30, 156, 230),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                            child: const Text('Login'),
                                            onPressed: () {
                                              loginValidation(context);
                                            },
                                          ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  loginValidation(BuildContext context) async {
    bool isLoginValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (usernameController.text.isEmpty) {
      isLoginValid = false;
      Get.snackbar('Username tidak boleh kosong!', 'Silakan coba lagi',
          backgroundColor: Colors.red.shade300,
          icon: const Icon(Icons.warning_amber_sharp));
    }
    isLoading.value = true;

    if (passwordController.text.isEmpty) {
      isLoginValid = false;
      Get.snackbar('Password tidak boleh kosong!', 'Silakan coba lagi',
          backgroundColor: Colors.red.shade300,
          icon: const Icon(Icons.warning_amber_sharp));
    }
    isLoading.value = true;

    if (isLoginValid) {
      await LoginService()
          .postAkses(
              '$baseUrl/api/auth/akses',
              json.encode({
                'username': usernameController.text,
                'password': passwordController.text
              }))
          .then((value) async {
        if (value.statusCode == 200) {
          dataStorage.write(key: 'username', value: usernameController.text);
          dataStorage.write(key: 'token', value: value.body['access_token']);
          Get.snackbar('SUCCESS', value.body['pesan'],
              backgroundColor: Colors.green.shade300,
              icon: const Icon(Icons.check_circle_outline),
              duration: const Duration(seconds: 1));
          Get.offAndToNamed(AppRoute.pilihRole);
        } else if (value.statusCode == 400) {
          Get.snackbar(value.body['pesan'], 'Silahkan coba lagi',
              backgroundColor: Colors.red.shade300,
              icon: const Icon(Icons.warning_amber_sharp));
        } else if (value.statusCode != 200 && value.statusCode != 400) {
          Get.snackbar('Server sedang dalam perbaikan',
              'Mohon hubungi koordinator cabang',
              backgroundColor: Colors.red.shade300,
              icon: const Icon(Icons.warning_amber_sharp));
        }
      });
    }
    isLoading.value = false;
  }
}
