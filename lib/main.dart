import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:risa_reborn/router/app_pages.dart';
import 'package:risa_reborn/router/app_routes.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.login,
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // themeMode: ThemeMode.light,
    );
  }
}
