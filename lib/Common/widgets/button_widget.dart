import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  String? image;
  final Function() onPressed;
  final String textUtils;
  final Color conternierColor;

  ButtonWidget(
      {this.image,
      required this.textUtils,
      required this.onPressed,
      required this.conternierColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 6.10.h,
        width: 33.84.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(backgroundColor: conternierColor),
            child: Row(
              children: [
                Image.asset(
                  image!,
                  width: 5.85.w,
                  height: 2.81.h,
                ),
                SizedBox(
                  width: 1.52.w,
                ),
                TextUtils(
                  color: Colors.white,
                  fontsize: 9.sp,
                  fontWeight: FontWeight.normal,
                  underLine: TextDecoration.none,
                  text: textUtils,
                ),
              ],
            )));
  }
}
