import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';



class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const AuthButton({
    required this.text,
    required this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black12,
          minimumSize: const Size(360, 50),
        ),
        onPressed: onPressed,
        child:  TextUtils(
            text: text,
            fontWeight: FontWeight.bold,
            fontsize: 18,
            color: Colors.white));
  }
}