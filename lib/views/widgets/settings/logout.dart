import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';



class LogOut extends StatelessWidget {
  LogOut({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Logout From App",
              titleStyle:  TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText: 'Are you sure you need to logout?',
              middleTextStyle:  TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.white,
              radius: 4,
              textCancel: " Cancel ",
              cancelTextColor: Colors.black,
              textConfirm: " Log Out ",
              confirmTextColor: Colors.red,
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                controller.signOut();
              },
              buttonColor: Colors.white,
            );
          },
          splashColor: Colors.black,
          borderRadius: BorderRadius.circular(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Logout",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
              ),

            ],
          ),
        ),
      ),
    );
  }
}