import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/theme.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final Widget? prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final maxLength;
  final int? maxLines;
  final String? numCode;

  const AuthTextFromField({
    required this.controller,
    required this.obscureText,
    required this.validator,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
    this.numCode,
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
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: TextInputType.text,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          prefixText: numCode,
          prefixStyle: TextStyle(color: labalColor),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
              color: const Color.fromRGBO(153, 162, 165, 0.47),
              fontSize: 11.sp,
              fontWeight: FontWeight.w400),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: labalColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: labalColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
