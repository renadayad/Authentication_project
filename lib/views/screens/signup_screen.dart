import 'package:auth_app/logic/controllers/auth_controller.dart';
import 'package:auth_app/routes.dart';
import 'package:auth_app/utils/my_string.dart';
import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/utils/theme.dart';
import 'package:auth_app/views/widgets/auth/auth_button.dart';
import 'package:auth_app/views/widgets/auth/icon_widget.dart';
import 'package:auth_app/views/widgets/auth/singnUpByButton.dart';
import 'package:auth_app/views/widgets/auth/text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 154, bottom: 363, right: 45, left: 55),
          child: Column(
            children: [
              TextUtils(
                  text: 'Sign Up by',
                  fontsize: 14,
                  fontWeight: FontWeight.normal,
                  color: mainColor,
                  underLine: TextDecoration.none),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  GetBuilder<AuthController>(builder: (_) {
                    return IconWidget(
                      conternierColor: googleColor,
                      onPressed: () async {
                        await controller.googleSignUpApp();
                      },
                      textUtils: 'with Google',
                      image: 'assets/images/image 14google.png',
                    );
                  }),
                  const SizedBox(
                    width: 16,
                  ),
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return IconWidget(
                        conternierColor: Colors.black,
                        onPressed: () {},
                        textUtils: 'with Apple',
                        image: 'assets/images/image 14google.png',
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 54,
              ),
              TextUtils(
                  text: 'or',
                  fontsize: 14,
                  fontWeight: FontWeight.normal,
                  color: mainColor,
                  underLine: TextDecoration.none),
              const SizedBox(
                height: 32,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                        text: 'E-mail',
                        fontsize: 14,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthTextFromField(
                      controller: emailController,
                      obscureText: false,
                      prefixIcon: const Icon(
          Icons.person_outline,

                        color: mainColor,
                      ),
                      suffixIcon: const Text(''),
                      validator: (value) {
                        if (!RegExp(validationEmail).hasMatch(value)) {
                          return 'Invalid Email';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Enter your E-mail',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextUtils(
                        text: 'Password',
                        fontsize: 14,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return AuthTextFromField(
                          controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: mainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.Visibilty();
                            },
                            icon: controller.isVisibilty
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    color: mainColor,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: mainColor,
                                    size: 20,
                                  ),
                          ),
                          obscureText: controller.isVisibilty ? false : true,
                          validator: (value) {
                            if (!RegExp(validationPassword).hasMatch(value)) {
                              return 'Password length must be 8 and contain a number,\n a special symbol, and an uppercase letter.';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Enter your password',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextUtils(
                        text: 'Re-Password',
                        fontsize: 14,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return AuthTextFromField(
                          controller: rePasswordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: mainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.Visibilty2();
                            },
                            icon: controller.isVisibilty2
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    color: mainColor,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: mainColor,
                                    size: 20,
                                  ),
                          ),
                          obscureText: controller.isVisibilty ? false : true,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return 'The entered password does not match.';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Enter your password again',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GetBuilder<AuthController>(
                        builder: (_) {
                          return AuthButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String email = emailController.text.trim();
                                  String password = passwordController.text;

                                  controller.signUpUsingFirebase(
                                      email: email, password: password);
                                }
                              },
                              text: 'Sign Up');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextUtils(
                            text: 'Already have account ?',
                            fontsize: 12,
                            fontWeight: FontWeight.normal,
                            color: mainColor,
                            underLine: TextDecoration.none),
                        const SizedBox(
                          width: 2,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.loginScreen);
                          },
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: TextUtils(
                              text: 'Login',
                              fontsize: 12,
                              fontWeight: FontWeight.w400,
                              color: buttonColor,
                              underLine: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
