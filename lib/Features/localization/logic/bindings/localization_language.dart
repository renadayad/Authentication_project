import 'package:get/get.dart';

import '../controllers/localization_language.dart';

class LocalizationLanguageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LocalizationLanguageController>(LocalizationLanguageController());
  }
}
