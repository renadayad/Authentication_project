import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../Common/utils/theme.dart';
import '../../../../Common/widgets/text_utils.dart';
import '../../../Auth/logic/controller/auth_controller.dart';
import '../../logic/controller/profile_controller.dart';

class HeaderWidet extends StatelessWidget {
  HeaderWidet({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.center,
          child: GetBuilder<ProfileController>(builder: (_) {
            return Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: profileController.image == "" ||
                              profileController.image == null
                          ? const AssetImage("assets/images/avtar.png")
                              as ImageProvider
                          : NetworkImage(
                              profileController.image,
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -11,
                  right: -11, //give the values according to your requirement
                  child: IconButton(
                    onPressed: () {
                      profileController.TakePhoto(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          })),
      SizedBox(
        height: 2.5.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<ProfileController>(builder: (_) {
            return TextUtils(
              text: profileController.updateNameController.text,
              color: Colors.black,
              fontsize: 12.sp,
              fontWeight: FontWeight.bold,
            );
          }),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.defaultDialog(
                  title: '',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: profileController.updateNameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            //labelText: "${profileController.name}",
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 4.0))),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                        ),
                        onPressed: () {
                          if (profileController.updateNameController.text !=
                              null) {
                            profileController.updateName(
                                profileController.updateNameController.text);
                            Get.back();
                          } else {
                            print("not edit");
                          }
                        },
                        child: TextUtils(
                          text: 'Edit',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontsize: 20,
                        ),
                      )
                    ],
                  ),
                  radius: 10.0);
            },
          ),
        ],
      ),
    ]);
  }
}
