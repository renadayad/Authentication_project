import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/auth_controller.dart';

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
            title: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Provide your account's email  for which you want to reset your password",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Enter your E-mail",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextFormField(
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