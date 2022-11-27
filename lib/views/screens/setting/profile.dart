import 'package:auth_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/settings/change_password.dart';
import '../../widgets/settings/edit_profile.dart';
import '../../widgets/settings/logout.dart';
import '../../widgets/settings/notification.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(backgroundColor: Get.isDarkMode ? Colors.black :Colors.white ,
          centerTitle: true,
          elevation: 0,
          title: Text('Settings' ,style: TextStyle(
              color: Colors.black
          ),
          ),
          leading: IconButton(
            onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ) ,
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
             SizedBox(
              height: 3.5.h,
            ),
            TextUtils(
              fontsize: 14.sp,
              fontWeight: FontWeight.bold,
              text: "Account",
              color: Colors.black,
            ),
             SizedBox(
              height: 3.5.h,
            ),
            EditProfile(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
             SizedBox(
              height: 0.5.h,
            ),
            ChangePassword(),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
             SizedBox(
              height: 0.5.h,
            ),
            NotificationWidget(),
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
    );
  }
}