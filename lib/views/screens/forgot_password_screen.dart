import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Common/utils/my_string.dart';
import '../../Features/Auth/logic/controller/auth_controller.dart';
import '../widgets/auth/auth_button.dart';
import '../../Common/widgets/text_form_field.dart';

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
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 2.3.h,
                ),
                const Text(
                  "Provide your account's email  for which you want to reset your password",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 2.3.h,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter your E-mail",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 2.3.h,
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
                SizedBox(
                  height: 5.8.h,
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
                      fontsize: 10.sp,
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
