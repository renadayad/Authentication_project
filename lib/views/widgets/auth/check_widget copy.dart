import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes.dart';
import '../../../utils/text_utils.dart';
import '../../../utils/theme.dart';

class CheckWidget2 extends StatelessWidget {
  CheckWidget2({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              controller.CheckBox();
            },
            child: Container(
              height: 2.11.h,
              width: 4.58.w,
              decoration: BoxDecoration(
                  color: labalColor, borderRadius: BorderRadius.circular(4)),
              child: controller.isCheckBox
                  ? Icon(
                      Icons.done,
                      size: 15,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.crop_square_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
            ),
          ),
          SizedBox(
            width: 2.54.w,
          ),
          TextUtils(
            text: "Remember me ",
            color: labalColor,
            fontWeight: FontWeight.normal,
            fontsize: 9.sp,
          ),
          SizedBox(
            width: 3.05.w,
          ),
        ],
      );
    });
  }
}
