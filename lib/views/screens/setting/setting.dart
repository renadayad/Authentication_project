import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'change_password.dart';
import 'edit_profile.dart';
import 'logout.dart';
import 'notification.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
             SizedBox(
              height: 3.5.h,
            ),
            TextUtils(
              fontsize: 14.sp,
              fontWeight: FontWeight.bold,
              text: "Account",
              color: Colors.black,
            ),
             SizedBox(
              height: 3.5.h,
            ),
            EditProfile(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
             SizedBox(
              height: 0.5.h,
            ),
            ChangePassword(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
             SizedBox(
              height: 0.5.h,
            ),
            NotificationWidget(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
             SizedBox(
              height: 0.5.h,
            ),
            LogOut(),
          ],
        ),
      ),
    );
  }
}