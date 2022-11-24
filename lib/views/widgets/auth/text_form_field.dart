import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final Widget? prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  const AuthTextFromField({
    required this.controller,
    required this.obscureText,
    required this.validator,
    this.prefixIcon,
    required this.suffixIcon,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: labalColor,
      keyboardType: TextInputType.text,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromRGBO(153, 162, 165, 0.47),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: labalColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: labalColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
