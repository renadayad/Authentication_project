import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Auth/logic/controller/auth_controller.dart';
import '../../logic/controller/profile_controller.dart';
import '../widgets/change_password_widget.dart';
import '../widgets/logout_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: GetBuilder<AuthController>(builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: GetBuilder<ProfileController>(builder: (_) {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: profileController.image == null
                                  ? const AssetImage("assets/images/avtar.png")
                                      as ImageProvider
                                  : NetworkImage(
                                      profileController.image,
                                    ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      })),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: GetBuilder<ProfileController>(builder: (_) {
                        return TextUtils(
                          text: profileController.name,
                          color: Colors.black,
                          fontsize: 12.sp,
                          fontWeight: FontWeight.bold,
                        );
                      })),
                  SizedBox(
                    height: 0.6.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ChangePaswwordWidget(),
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
            );
          })),
    );
  }
}
