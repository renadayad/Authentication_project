import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/header_widget.dart';
import '../widgets/signUp/signUp_email_form.dart';

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
              SizedBox(
                height: 6.3.h,
              ),
              HeaderWidget(),
              SizedBox(
                height: 5.h,
              ),
              SignUpEmailForm()
            ],
          ),
        ),
      ),
    );
  }
}
