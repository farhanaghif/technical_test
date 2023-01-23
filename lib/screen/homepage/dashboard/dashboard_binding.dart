import 'package:get/get.dart';
import 'package:risa_reborn/controller/Home_c/dashboard_controller.dart';
import 'package:risa_reborn/controller/Home_c/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
  }
}
