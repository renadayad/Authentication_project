import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  AuthTextFormField({
    required this.controller,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.validator,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black ),
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        prefixIcon:prefixIcon,
        suffixIcon:suffixIcon,
        hintText:hintText,
        hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
        filled:  true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
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
        ),

      ),

    );
  }
}