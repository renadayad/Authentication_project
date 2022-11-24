import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              titleStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText: 'Are you sure you need to logout?',
              middleTextStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
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
              const Text(
                "Logout",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
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