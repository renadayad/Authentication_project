import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../localization/logic/controllers/localization_language.dart';

class ChangeLanguageWidget extends StatelessWidget {
  ChangeLanguageWidget({super.key});
  final controller = Get.find<LocalizationLanguageController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Language".tr,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              color: Colors.black),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: DropdownButton(
            // Initial Value
            value: controller.selected,
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),
            // Array list of items
            items: controller.items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              if (newValue == 'Arabic') {
                controller.changeLanguage("ar");
                controller.setSelected('Arabic');
              } else {
                controller.changeLanguage("en");
                controller.setSelected('English');
              }
            },
          ),
        ),
      ],
    );
  }
}
