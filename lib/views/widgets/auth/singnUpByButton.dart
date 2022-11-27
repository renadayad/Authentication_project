import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpBy extends StatelessWidget {
  final Color bgcolor;
  final Function() onPressed;
  final String path;
  final String text;

  const SignUpBy(
      {super.key,
      required this.bgcolor,
      required this.onPressed,
      required this.path,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.1.h,
      width: 35.1.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: bgcolor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
        ),
        child: Row(
          children: [
            Image.asset(
              path,
              height: 2.8.h,
              width: 5.8.w,
              color: Colors.white,
            ),
            SizedBox(
              width: 1.5.w,
            ),
            TextUtils(
              text: text,
              fontsize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              underLine: TextDecoration.none,
            ),
          ],
        ),
      ),
    );
  }
}
