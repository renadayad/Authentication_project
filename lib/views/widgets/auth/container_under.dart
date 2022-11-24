import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/utils/theme.dart';
import 'package:flutter/material.dart';

class Container_Under extends StatelessWidget {
  final String text;
  final String typetext;
  final Function() onPressed;
  const Container_Under(
      {required this.text,
      required this.typetext,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
              text: text,
              color: labalColor,
              fontWeight: FontWeight.normal,
              fontsize: 12,
              underLine: TextDecoration.none),
          TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              child: TextUtils(
                  text: typetext,
                  color: buttonColor,
                  fontWeight: FontWeight.w400,
                  fontsize: 12,
                  underLine: TextDecoration.underline))
        ],
      ),
    );
  }
}
