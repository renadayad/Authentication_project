import 'package:auth_app/views/widgets/auth/container_under.dart';
import 'package:auth_app/views/widgets/auth/icon_widget.dart';
import 'package:auth_app/views/widgets/auth/login_email_form.dart';
import 'package:auth_app/views/widgets/auth/login_phone_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../routes.dart';
import '../../utils/my_string.dart';
import '../../utils/text_utils.dart';
import '../../utils/theme.dart';
import '../widgets/auth/check_widget.dart';
import '../widgets/auth/auth_button.dart';
import '../widgets/auth/text_form_field.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 154, bottom: 363, right: 45, left: 55),
        child: Column(children: [
          TextUtils(
            text: "Login by",
            color: labalColor,
            fontWeight: FontWeight.normal,
            fontsize: 11.sp,
            underLine: TextDecoration.none,
          ),
          SizedBox(
            height: 5.8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AuthController>(builder: (_) {
                return IconWidget(
                  conternierColor: conternierColor,
                  onPressed: () {
                    controller.loginUsinggoogle();
                  },
                  image: 'assets/images/image 14google.png',
                  textUtils: "with Google",
                );
              }),
              SizedBox(
                width: 5.08.w,
              ),
              IconWidget(
                conternierColor: Colors.black,
                onPressed: () {},
                image: 'assets/images/image 16Apple.png',
                textUtils: "with Apple",
              ),
            ],
          ),
          SizedBox(
            height: 7.04.h,
          ),
          TextUtils(
              text: "or",
              color: labalColor,
              fontWeight: FontWeight.normal,
              fontsize: 11.sp,
              underLine: TextDecoration.none),
          SizedBox(
            height: 2.34.h,
          ),
          Container(
            height: 4.69.h,
            child: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: labalColor,
                tabs: [
                  Tab(
                    child: Text("Email", style: TextStyle(fontSize: 12.sp)),
                  ),

                  Tab(
                      child: Text("Phone number",
                          style: TextStyle(fontSize: 12.sp)))
                ]),
          ),
          Container(
            height: 46.60.h,
            child: TabBarView(
                controller: controller.tabController,
                children: [Login_Email_Form(), Login_PhoneNumber_Form()]),
          ),
        ]),
      ),
    );
  }
}
