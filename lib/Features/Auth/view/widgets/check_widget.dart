




import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Common/utils/theme.dart';
import '../../../../Core/routes/routes.dart';
import '../../logic/controller/auth_controller.dart';

class CheckWidget extends StatelessWidget {
  CheckWidget( this.widget,{super.key , required this.isChecked, required this.function });
  final bool isChecked;
  final Function() function;
  final controller = Get.find<AuthController>();

  final Widget? widget;

  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? newValue) {
             function();
            },
            checkColor: Colors.white,
            activeColor: Colors.white,
            fillColor: MaterialStateProperty.all(mainColor),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),

          TextUtils(
            text: "Remmber Me".tr,

            color: Colors.grey,
            fontWeight: FontWeight.normal,
          fontsize: 10.sp,
          ),
        Spacer(),


          widget!
          // Align(
          //   alignment: Alignment.center,
          //   child: TextButton(
          //     onPressed: (() {
          //       Get.toNamed(Routes.forgotpasswordScreen);
          //     }),
          //     child: TextUtils(
          //         text: "Don't remember the password? ",
          //         color: labalColor,
          //         fontWeight: FontWeight.normal,
          //         fontsize: 7.sp,
          //         underLine: TextDecoration.underline),
          //   ),
          // )

        ],
      );

  }
}
