import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../utils/my_string.dart';
import '../widgets/auth/auth_button.dart';
import '../widgets/auth/text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black45,),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              30
            ),
            child: Column(
              children: [

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Provide your account's email  for which you want to reset your password",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter your E-mail",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthTextFromField(
                  controller: emailController,
                  obscureText: false,
                  validator: (value) {
                    if (!RegExp(validationEmail).hasMatch(value)) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: const Text(""),
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 50,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  return AuthButton(
                      text: "Request reset password link",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String email = emailController.text.trim();
                          controller.resetPassword(email);
                        }
                      });
                }),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: TextUtils(
                      text: "Cancel",
                      fontWeight: FontWeight.w500,
                      fontsize: 13,
                      color: Colors.black,
                      underLine: TextDecoration.underline,
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
