import 'dart:async';

import 'package:auth_app/logic/controllers/auth_controller.dart';
import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/utils/theme.dart';
import 'package:auth_app/views/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatelessWidget {
  String phoneNumber;
  OTPScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    StreamController<ErrorAnimationType>? errorController;
    bool hasError = false;
    String currentText = "";
    final formKey = GlobalKey<FormState>();
    final controller = Get.find<AuthController>();
    var isbuttonDisable = controller.isbuttonDisable;

    // @override
    // void initState() {
    //   errorController = StreamController<ErrorAnimationType>();
    // }

    // @override
    // void dispose() {
    //   errorController!.close();
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextUtils(
            text: 'Code verification',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 13.sp),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 20),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 4.1.h),

              SizedBox(height: 0.9.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextUtils(
                    text: 'Enter OTP',
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontsize: 11.sp,
                    underLine: TextDecoration.none,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "sent to ",
                      children: [
                        TextSpan(
                            text: "$phoneNumber",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 11.sp)),
                  textAlign: TextAlign.center,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 11.sp),
                  ),
                  Obx(
                    () => Text('${controller.time.value}'),
                  ),
                ],
              ),

              SizedBox(
                height: 1.1.h,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,

                      length: 6,

                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (value) {},
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(7),
                          fieldHeight: 5.6.h,
                          fieldWidth: 11.w,
                          activeColor: mainColor,
                          selectedColor: mainColor,
                          inactiveColor: mainColor,
                          errorBorderColor: Colors.red),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: otpController,
                      keyboardType: TextInputType.number,

                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        // debugPrint(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                    )),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Text(
              //     hasError ? "*Please fill up all the cells " : "",
              //     style:  TextStyle(
              //         color: Colors.red,
              //         fontSize: 10.sp,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 90),
                // ignore: sort_child_properties_last
                child: ButtonTheme(


                    height: 32,
                    child:  Column(

                    children: [
                      AuthButton(
                          onPressed: () {
                            controller.verifyOTP(otpController.text);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                });
                          },
                          text: 'Verify code'),
                      GetBuilder<AuthController>(builder: (_) {
                        return TextButton(
                          onPressed: controller.isbuttonDisable
                              ? () async {
                                  controller.reSendOTP(phone: phoneNumber);
                                }
                              : null,
                          child: TextUtils(
                            text: 'Resend code',
                            color: isbuttonDisable ? Colors.green : mainColor,
                            fontWeight: FontWeight.w400,
                            fontsize: 11.sp,
                            underLine: TextDecoration.underline,
                          ),
                        );
                      })
                    ],
                  ),
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// https://pub.dev/packages/pin_code_fields 