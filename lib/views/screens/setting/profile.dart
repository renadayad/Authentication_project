import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/views/widgets/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/setting_controller.dart';
import '../../widgets/settings/change_password.dart';
import '../../widgets/settings/edit_profile.dart';
import '../../widgets/settings/logout.dart';
import '../../widgets/settings/notification.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  final controller = Get.find<SettingController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(backgroundColor: Get.isDarkMode ? Colors.black :Colors.white ,
          centerTitle: true,
          elevation: 0,
          title: Text('Profile' ,style: TextStyle(
              color: Colors.black
          ),
          ),
          leading: IconButton(
            onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ) ,
        ),
        body:  Padding(
          padding: const EdgeInsets.all(16),
          child: Column(

            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
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
              ),),
              SizedBox(
                height: 2.5.h,
              ),
              Align(alignment: Alignment.center,
                child: TextUtils(text: "Username",color: Colors.black,fontsize: 11.sp,fontWeight: FontWeight.bold,),),
              SizedBox(
                height: 1.3.h,
              ),
              Align(alignment: Alignment.center,
                child: TextUtils(text: authController.displayUserEmail.value,color: Colors.black45,fontsize: 9.sp,fontWeight: FontWeight.w500,),),

               SizedBox(
                height: 5.h,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextUtils(
                  fontsize: 14.sp,
                  fontWeight: FontWeight.bold,
                  text: "Account",
                  color: Colors.grey.shade700,
                ),
              ),
               SizedBox(
                height: 2.5.h,
              ),
              EditProfile(),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
               SizedBox(
                height: 0.5.h,
              ),
              SettingsWidget(),

            ],
          ),
        ),
      ),
    );
  }
}