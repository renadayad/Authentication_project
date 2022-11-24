import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';

class SignUpBy extends StatelessWidget {
  final Color bgcolor;
  final Function() onPressed;
  final String path;
  // final Color color;
  final String text;

  const SignUpBy(
      {super.key,
      required this.bgcolor,
      required this.onPressed,
      required this.path,
      //required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 138,
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
              height: 24,
              width: 23,
              color: Colors.white,
            ),
            const SizedBox(
              width: 6,
            ),
            TextUtils(
              text: text,
              fontsize: 14,
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
