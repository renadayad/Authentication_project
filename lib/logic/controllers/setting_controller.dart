


import 'package:get/get.dart';


class SettingController extends GetxController {
  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

}