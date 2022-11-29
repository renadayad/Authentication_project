import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/text_utils.dart';
import '../../../utils/theme.dart';
import 'auth_button.dart';
import 'text_form_field.dart';

class SignUp_Phone_Number_Form extends StatelessWidget {
  SignUp_Phone_Number_Form({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          TextUtils(
              text: 'Name',
              fontsize: 11.sp,
              fontWeight: FontWeight.normal,
              color: mainColor,
              underLine: TextDecoration.none),
          SizedBox(
            height: 1.1.h,
          ),
          AuthTextFromField(
            controller: nameController,
            obscureText: false,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: mainColor,
            ),
            suffixIcon: const Text(''),
            validator: (value) {
              if (value.toString().isEmpty) {
                return 'Enter your name ';
              } else {
                return null;
              }
            },
            hintText: 'Enter your name',
          ),
          SizedBox(
            height: 1.7.h,
          ),
          TextUtils(
              text: 'Phone number',
              fontsize: 11.sp,
              fontWeight: FontWeight.normal,
              color: mainColor,
              underLine: TextDecoration.none),
          SizedBox(
            height: 1.1.h,
          ),
          AuthTextFromField(
            controller: phoneNumberController,
            obscureText: false,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: mainColor,
            ),
            suffixIcon: const Text(''),
            validator: (value) {
              if (!RegExp(validationNumber).hasMatch(value)) {
                return 'Invalid phone number';
              } else {
                return null;
              }
            },
            hintText: 'Enter your phone number',
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
                        String email = phoneNumberController.text.trim();
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
    );
  }
}
