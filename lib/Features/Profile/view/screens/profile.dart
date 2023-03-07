import 'package:auth_app/Common/widgets/text_utils.dart';
import 'package:auth_app/Features/Profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../Common/utils/theme.dart';
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
    profileController.getNameField();
    profileController.getImageField();
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                HeaderWidet(),
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


            ),
          ),
    );
  }
}
