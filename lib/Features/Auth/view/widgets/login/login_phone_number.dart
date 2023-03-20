import 'package:auth_app/Common/models/UserModel.dart';
import 'package:auth_app/Features/Auth/logic/controller/auth_controller.dart';
import 'package:auth_app/Core/routes/routes.dart';
import 'package:auth_app/Common/utils/my_string.dart';
import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:auth_app/Common/utils/theme.dart';
import 'package:auth_app/Features/Auth/view/widgets/check_widget.dart';
import 'package:auth_app/Common/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Common/widgets/auth_button_widget.dart';
import '../../../../../Common/widgets/container_under_widget.dart';
import '../../screens/otp_screen.dart';

class Login_PhoneNumber_Form extends StatelessWidget {
  Login_PhoneNumber_Form({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    //***********************
    controller.isCheckBoxPhone = GetStorage().read("checKBoxPhone") == null
        ? false
        : GetStorage().read("checKBoxPhone");
    print(controller.isCheckBoxPhone);
    //*******************************************
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextUtils(
                text: 'Phone number',
                color: labalColor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp,
                underLine: TextDecoration.none),
          ),
          SizedBox(
            height: 1.17.h,
          ),
          AuthTextFromField(
            controller: controller.phoneNumberController,
            obscureText: false,
            validator: (value) {
              if (!RegExp(validationNumber).hasMatch(value)) {
                return "Worng Phone Number";
              } else {
                return null;
              }
            },
            numCode: "+966 ",
            prefixIcon: Icon(
              Icons.phone_outlined,
              color: labalColor,
            ),
            suffixIcon: const Text(''),
            hintText: "53*******",
          ),
          SizedBox(
            height: 1.17.h,
          ),
          GetBuilder<AuthController>(builder: (_) {
            return CheckWidget(
              isChecked: controller.isCheckBoxPhone,
              function: controller.CheckBoxPhone,
            );
          }),
          SizedBox(
            height: 3.75.h,
          ),
          GetBuilder<AuthController>(builder: (_) {
            return AuthButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  controller.isButtonDisableVerifyCode = true;
                  controller.isButtonDisableResendCode = false;
                  controller.verifyPhone(
                    phone: controller.phoneNumberController.text.trim(),
                  );
                  controller.startTimer(60);
                  await Get.to(
                    OTPScreen(
                      phonenumber: controller.phoneNumberController.text,
                    ),
                  );
                }
              },
              text: "Log In",
            );
          }),
          SizedBox(
            height: 1.17.h,
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
    );
  }
}
