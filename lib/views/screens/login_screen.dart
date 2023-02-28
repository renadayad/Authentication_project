import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:auth_app/Common/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Features/Auth/view/widgets/header_widget.dart';
import '../../Features/Auth/view/widgets/onTap_widget.dart';
import '../widgets/auth/login_email_form.dart';
import '../widgets/auth/login_phone_number.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({super.key});
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
                firstTap: Login_Email_Form(),
                secandTap: Login_PhoneNumber_Form(), height: 450,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
