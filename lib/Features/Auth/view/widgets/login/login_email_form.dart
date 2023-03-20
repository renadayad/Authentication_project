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

class LoginEmailForm extends StatelessWidget {
  LoginEmailForm({super.key});
  final formKey = GlobalKey<FormState>();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    //***********************
    controller.isCheckBoxEmail = GetStorage().read("checKBox") == null
        ? false
        : GetStorage().read("checKBox");
    print("############################");
    print("Hyyyyyy ${controller.isCheckBoxEmail}");
    //*******************************************
    return Form(
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
                fontsize: 11.sp,
                underLine: TextDecoration.none),
          ),
          SizedBox(
            height: 1.17.h,
          ),
          AuthTextFromField(
            controller: controller.emailController,
            obscureText: false,
            validator: (value) {
              if (!RegExp(validationEmail).hasMatch(value)) {
                return "Worng E-mail";
              } else {
                return null;
              }
            },
            prefixIcon: Icon(
              Icons.email_outlined,
              color: labalColor,
            ),
            suffixIcon: const Text(''),
            hintText: "Enter your Email",
          ),
          SizedBox(
            height: 1.76.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextUtils(
                text: 'Password',
                color: labalColor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp,
                underLine: TextDecoration.none),
          ),
          SizedBox(
            height: 1.17.h,
          ),
          GetBuilder<AuthController>(builder: (_) {
            return AuthTextFromField(
              maxLines: 1,
              controller: controller.passwordController,
              obscureText: controller.isVisibiltyPassword ? false : true,
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
                  controller.VisibiltyPassword();
                },
                icon: controller.isVisibiltyPassword
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
            height: 1.17.h,
          ),
          Row(
            children: [
              Expanded(
                child: GetBuilder<AuthController>(builder: (_) {
                  return CheckWidget(
                    isChecked: controller.isCheckBoxEmail,
                    function: controller.CheckBoxEmail,
                  );
                }),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: (() {
                    Get.toNamed(Routes.forgotpasswordScreen);
                  }),
                  child: TextUtils(
                      text: "Don't remember the password? ",
                      color: labalColor,
                      fontWeight: FontWeight.normal,
                      fontsize: 7.sp,
                      underLine: TextDecoration.underline),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.75.h,
          ),
          AuthButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                String email = controller.emailController.text.trim();
                String password = controller.passwordController.text;
                controller.loginUsingFierbase(email: email, password: password);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
              }
            },
            text: "Log In",
          ),
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
