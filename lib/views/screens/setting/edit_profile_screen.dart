import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/views/widgets/auth/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/setting_controller.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final controller = Get.find<SettingController>();
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print("this is ${authController.displayUserEmailUpdate.value}");
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(onPressed: () async{
                  authController.getEmailDoc();
                  if (emailController.text.isNotEmpty){authController.updateEmail(emailController);}else{
                    Get.snackbar(
                      'Error!',
                      "error",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red[400],
                      colorText: Colors.white,
                    );
                  }



                }, child: TextUtils(text: "save", color: Colors.green, fontWeight: FontWeight.w700, fontsize: 12.sp))
              ],


            ),
            body: Obx(() => Padding(
                 padding: EdgeInsets.all(20),
                  child: Column(children: [
                    SizedBox(
                      height: 4.h,
                    ),
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
                     SizedBox(
                      height: 5.h,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(padding: EdgeInsets.only(left: 30,right: 30), child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextUtils(
                                text: 'Name',
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w400,
                                fontsize: 11.sp,
                                underLine: TextDecoration.none),
                          ),
                          SizedBox(
                            height: 1.17.h,
                          ),
                          Obx(()=> AuthTextFromField(
                            controller: emailController,
                            obscureText: false,
                            validator: (value) {
                              if (!RegExp(validationEmail).hasMatch(value)) {
                                return "Worng E-mail";
                              } else {
                                return null;
                              }
                            },

                            suffixIcon: const Text(''),
                            hintText:authController.displayUserEmailUpdate.value,
                          ),)
                        ],
                      ) ,)
                    ),
                  ]),
                ))));
  }
}
