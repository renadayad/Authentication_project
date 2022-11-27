import 'package:auth_app/logic/controllers/auth_controller.dart';
import 'package:auth_app/routes.dart';
import 'package:auth_app/utils/my_string.dart';
import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/utils/theme.dart';
import 'package:auth_app/views/widgets/auth/auth_button.dart';
import 'package:auth_app/views/widgets/auth/icon_widget.dart';
import 'package:auth_app/views/widgets/auth/text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
                  fontsize: 11.sp,
                  fontWeight: FontWeight.normal,
                  color: mainColor,
                  underLine: TextDecoration.none),
              SizedBox(
                height: 3.7.h,
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
                  SizedBox(
                    width: 4.w,
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
              SizedBox(
                height: 6.3.h,
              ),
              TextUtils(
                  text: 'or',
                  fontsize: 11.sp,
                  fontWeight: FontWeight.normal,
                  color: mainColor,
                  underLine: TextDecoration.none),
              SizedBox(
                height: 3.7.h,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                        text: 'E-mail',
                        fontsize: 11.sp,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    SizedBox(
                      height: 1.1.h,
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
                    SizedBox(
                      height: 1.7.h,
                    ),
                    TextUtils(
                        text: 'Password',
                        fontsize: 11.sp,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    SizedBox(
                      height: 1.1.h,
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
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: mainColor,
                                    size: 2.3.h,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: mainColor,
                                    size: 2.3.h,
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
                    SizedBox(
                      height: 1.7.h,
                    ),
                    TextUtils(
                        text: 'Re-Password',
                        fontsize: 11.sp,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        underLine: TextDecoration.none),
                    SizedBox(
                      height: 1.1.h,
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
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: mainColor,
                                    size: 2.3.h,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: mainColor,
                                    size: 2.3.h,
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
                    SizedBox(
                      height: 3.5.h,
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
                            fontsize: 9.sp,
                            fontWeight: FontWeight.normal,
                            color: mainColor,
                            underLine: TextDecoration.none),
                        SizedBox(
                          width: 0.5.w,
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
                              fontsize: 9.sp,
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
