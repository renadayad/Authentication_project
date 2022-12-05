import 'dart:io';

import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/views/widgets/auth/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/setting_controller.dart';
import '../../../utils/my_string.dart';


class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(SettingController());
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("this is image in edit ${authController.displayUserPhoto.value}");
    print("this is description in edit  ${authController.displayDescription.value
    }");
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              actions: [

                TextButton(onPressed: () async{
                  controller.getNameField();
                  controller.getDescriptionFeild();
                  if(nameController.text.isNotEmpty || descriptionController.text.isNotEmpty || authController.displayUserPhoto.value.isNotEmpty){
                    authController.updateFields(nameController, descriptionController, authController.displayUserPhoto.value);
                  }else{
                    Get.snackbar(
                      'Error!',
                      'Error!',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                    );
                  }

                  }

                , child: TextUtils(text: "save", color: Colors.green, fontWeight: FontWeight.w700, fontsize: 12.sp))

              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(
                  height: 4.h,
                ),
                


                      Obx(() =>
                          Stack(
                              children:[Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:authController.displayUserPhoto.value == ""
                                        ? const AssetImage("assets/images/avtar.png")
                                    as ImageProvider
                                        : NetworkImage(
                                      authController.displayUserPhoto.value,
                                    ),
                                    // FileImage(controller.image!),

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                                Positioned(
                                  bottom: -2, right: -1, //give the values according to your requirement
                                  child: IconButton( onPressed: () {
                                    _onPictureSelection();
                                  }, icon: const Icon(Icons.camera_alt_outlined,),),
                                ),

                              ]
                          ),
                      ) ,
                     SizedBox(
                      height: 5.h,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(padding: const EdgeInsets.only(left: 30,right: 30), child:Column(

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
                            controller: nameController,
                            obscureText: false,
                            validator: (value) {
                              if (!RegExp(validationEmail).hasMatch(value)) {
                                return "Worng E-mail";
                              } else {
                                return null;
                              }
                            },

                            suffixIcon: const Text(''),
                            hintText:authController.displayUserName.value,
                          ),),
                        SizedBox(
                          height: 1.17.h,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextUtils(
                                text: 'Description',
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w400,
                                fontsize: 11.sp,
                                underLine: TextDecoration.none),
                          ),
                          SizedBox(
                            height: 1.17.h,
                          ),

                          Obx(()=>
                            AuthTextFromField(
                              controller: descriptionController,
                              obscureText: false,
                              validator: (value) {
                                if (!RegExp(validationName).hasMatch(value)) {
                                  return "Invalid name";

                                } else {
                                  return null;
                                }
                              },


                              suffixIcon: const Text(''),
                              maxLength: 100,
                              maxLines: 4,
                              hintText:authController.displayDescription.value,
                            ),
                          ),





                        ],
                      ),
                    )),
              ]),
            )));
  }

  _onPictureSelection() async {
    await controller.getImageFeild();
    await controller.getImage();
  }
}
