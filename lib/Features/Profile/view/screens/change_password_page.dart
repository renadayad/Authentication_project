import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Common/utils/theme.dart';
import '../../../../Common/widgets/auth_button_widget.dart';
import '../../../../Common/widgets/text_form_field.dart';
import '../../../Auth/logic/controller/auth_controller.dart';
import '../../logic/controller/profile_controller.dart';

class ChangePsswordPage extends StatelessWidget {
  ChangePsswordPage({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            controller.clearController();
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    TextUtils(
                      text: "Current Password".tr,
                      color: mainColor,
                      fontWeight: FontWeight.w400,
                      fontsize: 8.sp,
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    AuthTextFromField(
                      maxLines: 1,
                      controller: controller.passController,
                      validator: (value) {
                        if (value.toString().length < 6) {
                          return 'The entered password is not correct.';
                          // } else if (value != controller.password) {
                          //   return 'The entered password does not same current password.';
                        } else if (controller.passController ==
                            controller.newPassController) {
                          return "same password";
                        } else {
                          return null;
                        }
                      },
                      hintText: '********',
                      obscureText: false,
                      suffixIcon: const Text(""),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    TextUtils(
                      text: "New Password".tr,
                      color: mainColor,
                      fontWeight: FontWeight.w400,
                      fontsize: 8.sp,
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    GetBuilder<AuthController>(builder: (_) {
                      return AuthTextFromField(
                        maxLines: 1,
                        controller: controller.newPassController,
                        validator: (value) {
                          if (value.toString().length < 6) {
                            return 'Please enter a correct password';
                          } else if (value == controller.passController.text) {
                            return "You entered the same current password.";
                          } else {
                            return null;
                          }
                        },
                        hintText: '********',
                        obscureText: false,
                        suffixIcon: const Text(""),
                      );
                    }),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    TextUtils(
                      text: "Re-type New Password".tr,
                      color: mainColor,
                      fontWeight: FontWeight.w400,
                      fontsize: 8.sp,
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    AuthTextFromField(
                      maxLines: 1,
                      controller: controller.rePasswordController,
                      validator: (value) {
                        if ((value != controller.newPassController.text)) {
                          return 'The entered password does not match.';
                        } else {
                          return null;
                        }
                      },
                      hintText: '********',
                      obscureText: false,
                      suffixIcon: const Text(""),
                    ),
                    SizedBox(
                      height: 3.4.h,
                    ),
                    SizedBox(
                      height: 5.3.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: AuthButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            controller.changePassword(
                              oldPassword: controller.passController.text,
                              newPassword: controller.newPassController.text,
                            );
                          }
                        },
                        text: 'Edit',
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    ));
  }
}
