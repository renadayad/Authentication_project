import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/localization_language.dart';

class settingScreen extends StatelessWidget {
  const settingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocalizationLanguageController>();
    // Initial Selected Value
    String dropdownvalue = controller.intialLang.toString();
    // List of items in our dropdown menu
    var items = [
      'en',
      'ar',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("setting".tr),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "settingLanguage".tr,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 50,
            ),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                controller.changeLanguage(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
