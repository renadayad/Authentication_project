import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Common/utils/theme.dart';
import '../../../../Common/widgets/button_widget.dart';
import '../../../../Common/widgets/text_utils.dart';
import '../../logic/controller/auth_controller.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextUtils(
            text: 'Sign Up by',
            fontsize: 11.sp,
            fontWeight: FontWeight.normal,
            color: mainColor,
            underLine: TextDecoration.none),
        SizedBox(
          height: 3.7.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              conternierColor: googleColor,
              onPressed: () async {
                await controller.loginUsinggoogle();

              },
              textUtils: 'with Google',
              image: 'assets/images/image 14google.png',
            ),
            SizedBox(
              width: 4.w,
            ),
            ButtonWidget(
              conternierColor: Colors.black,
              onPressed: () {},
              textUtils: 'with Apple',
              image: 'assets/images/image 14google.png',
            ),
          ],
        ),
      ],
    );
  }
}
