import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            const SizedBox(
              height: 30,
            ),
            TextUtils(
              fontsize: 18,
              fontWeight: FontWeight.bold,
              text: "Account",
              color: Colors.black,
            ),
            const SizedBox(
              height: 30,
            ),
            EditProfile(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            ChangePassword(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            NotificationWidget(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            LogOut(),
          ],
        ),
      ),
    );
  }
}