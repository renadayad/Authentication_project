import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/text_utils.dart';
import '../../../utils/theme.dart';
import '../../screens/otp_screen.dart';
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
            height: 1.8.h,
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
            numCode: "+966 ",
            obscureText: false,
            prefixIcon: const Icon(
              Icons.phone_outlined,
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
            hintText: '53*******',
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
                maxLines: 1,
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
                maxLines: 1,
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        controller.verifyPhone(
                            phone: phoneNumberController.text.trim(),
                            password: passwordController.text);


                    await    Get.to(OTPScreen(

                          phoneNumber: phoneNumberController.text,
                        ));
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
