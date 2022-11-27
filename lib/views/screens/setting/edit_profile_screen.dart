import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/views/widgets/auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/setting_controller.dart';



class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final controller = Get.find<SettingController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    print("this is ${authController.displayUserEmail.value}");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(
                  () => Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: authController.displayUserPhoto.isNotEmpty
                            ? NetworkImage(
                          authController.displayUserPhoto.value,
                        )
                            : NetworkImage(
                            "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextUtils(
                        fontsize: 22,
                        fontWeight: FontWeight.bold,
                        text:
                        controller.capitalize(authController.displayUserName.value),
                        color:  Colors.black,
                      ),
                      TextUtils(
                        fontsize: 14,
                        fontWeight: FontWeight.bold,
                        text: authController.displayUserEmail.value,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
