import 'package:auth_app/views/widgets/auth/container_under.dart';
import 'package:auth_app/views/widgets/auth/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../routes.dart';
import '../../utils/my_string.dart';
import '../../utils/text_utils.dart';
import '../../utils/theme.dart';
import '../widgets/auth/check_widget.dart';
import '../widgets/auth/auth_button.dart';
import '../widgets/auth/text_form_field.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 154, bottom: 363, right: 45, left: 55),
        child: Column(children: [
          TextUtils(
              text: "Login by",
              color: labalColor,
              fontWeight: FontWeight.normal,
              fontsize: 11.sp,
              underLine: TextDecoration.none),
          SizedBox(
            height: 5.8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AuthController>(builder: (_) {
                return IconWidget(
                  conternierColor: conternierColor,
                  onPressed: () {
                    controller.loginUsinggoogle();
                  },
                  image: 'assets/images/image 14google.png',
                  textUtils: "with Google",
                );
              }),
              SizedBox(
                width: 20,
              ),
              IconWidget(
                conternierColor: Colors.black,
                onPressed: () {},
                image: 'assets/images/image 16Apple.png',
                textUtils: "with Apple",
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          TextUtils(
              text: "or",
              color: labalColor,
              fontWeight: FontWeight.normal,
              fontsize: 14,
              underLine: TextDecoration.none),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextUtils(
                      text: 'E-mail',
                      color: labalColor,
                      fontWeight: FontWeight.w400,
                      fontsize: 14,
                      underLine: TextDecoration.none),
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextFromField(
                  controller: emailController,
                  obscureText: false,
                  validator: (value) {
                    if (!RegExp(validationEmail).hasMatch(value)) {
                      return "Worng E-mail";
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: labalColor,
                  ),
                  suffixIcon: const Text(''),
                  hintText: "Enter your Email",
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextUtils(
                      text: 'Password',
                      color: labalColor,
                      fontWeight: FontWeight.w400,
                      fontsize: 14,
                      underLine: TextDecoration.none),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  return AuthTextFromField(
                    controller: passwordController,
                    obscureText: controller.isVisibilty ? false : true,
                    validator: (value) {
                      if (value.toString().length < 6) {
                        return " Worng password";
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: labalColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.Visibilty();
                      },
                      icon: controller.isVisibilty
                          ? Icon(Icons.visibility_outlined,
                              color: labalColor, size: 20)
                          : Icon(Icons.visibility_off_outlined,
                              color: labalColor, size: 20),
                      iconSize: 18,
                    ),
                    hintText: "Enter your password",
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                CheckWidget(),
                SizedBox(
                  height: 32,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  return AuthButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String email = emailController.text.trim();
                        String password = passwordController.text;
                        controller.loginUsingFierbase(
                            email: email, password: password);
                      }
                    },
                    text: "Log In",
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Container_Under(
                  text: 'Dont hava an account?',
                  typetext: "Sign up",
                  onPressed: () {
                    Get.offNamed(Routes.signScreen);
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
