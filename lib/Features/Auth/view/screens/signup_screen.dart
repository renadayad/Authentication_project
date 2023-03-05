import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:auth_app/Common/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../logic/controller/auth_controller.dart';
import '../widgets/header_widget.dart';
import '../widgets/onTap_widget.dart';
import '../widgets/signUp/signUp_email_form.dart';
import '../widgets/signUp/signUp_phone_number_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 90, bottom: 163, right: 40, left: 50),
          child: Column(
            children: [
              HeaderWidget(),
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
                height: 2.3.h,
              ),
              TabWidget(
                firstTap: SignUpEmailForm(),
                secandTap: SignUpPhoneNumberForm(),
                height: 650,
              )
            ],
          ),
        ),
      ),
    );
  }
}
