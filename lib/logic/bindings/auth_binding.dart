import 'package:auth_app/logic/controllers/setting_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';



class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());

  }
}