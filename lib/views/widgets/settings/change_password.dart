import 'package:auth_app/Features/Profile/logic/controller/profile_controller.dart';
import 'package:auth_app/views/screens/setting/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Features/Auth/logic/controller/auth_controller.dart';
import '../../../Features/Profile/view/screens/change_password_page.dart';
import '../../screens/forgot_password_screen.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(() => ChangePsswordPage());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.transparent,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
