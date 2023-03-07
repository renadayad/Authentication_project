import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationLanguageController extends GetxController {
  var items = [
    'English',
    'Arabic',
  ];
  String selected = GetStorage().read('lang') == 'ar' ? "Arabic" : "English";

  void setSelected(String? value) {
    selected = value!;
  }

  Locale intialLang =
      GetStorage().read('lang') == 'ar' ? Locale('ar') : Locale('en');

  void changeLanguage(String codelang) async {
    Locale locale = Locale(codelang);
    intialLang = Locale(codelang);
    await GetStorage().write('lang', codelang);
    Get.updateLocale(locale);
    update();
  }
}
