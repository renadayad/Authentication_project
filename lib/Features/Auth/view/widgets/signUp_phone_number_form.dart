import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Core/routes/routes.dart';
import '../../../../Common/utils/my_string.dart';
import '../../../../Common/widgets/text_utils.dart';
import '../../../../Common/utils/theme.dart';
import '../../../../views/widgets/auth/auth_button.dart';
import '../../../../Common/widgets/text_form_field.dart';
import '../../logic/controller/auth_controller.dart';
import '../screens/otp_screen.dart';

class SignUpPhoneNumberForm extends StatelessWidget {
  SignUpPhoneNumberForm({super.key});

  final formKey = GlobalKey<FormState>();
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
            controller: controller.nameController,
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
            controller: controller.phoneNumberController,
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
                controller: controller.passwordController,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: mainColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.VisibiltyPassword();
                  },
                  icon: controller.isVisibiltyPassword
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
                obscureText: controller.isVisibiltyPassword ? false : true,
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
                controller: controller.rePasswordController,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: mainColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.VisibiltyRePassword();
                  },
                  icon: controller.isVisibiltyRePassword
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
                obscureText: controller.isVisibiltyRePassword ? false : true,
                validator: (value) {
                  if (value != controller.passwordController.text) {
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
                            phone: controller.phoneNumberController.text.trim(),
                            password: controller.passwordController.text);
                        controller.startTimer(60);

                        await Get.to(OTPScreen(
                          phoneNumber: controller.phoneNumberController.text,
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
