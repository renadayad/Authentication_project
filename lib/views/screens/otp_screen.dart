import 'dart:async';

import 'package:auth_app/utils/text_utils.dart';
import 'package:auth_app/utils/theme.dart';
import 'package:auth_app/views/widgets/auth/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = '55555555';
    TextEditingController textEditingController = TextEditingController();
    StreamController<ErrorAnimationType>? errorController;
    bool hasError = false;
    String currentText = "";
    final formKey = GlobalKey<FormState>();

    @override
    void initState() {
      errorController = StreamController<ErrorAnimationType>();
      //super.initState();
    }

    @override
    void dispose() {
      errorController!.close();

      //super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Code verification'),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 35),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 3,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(30),
              //     //child: Image.asset(Constants.otpGifImage),
              //   ),
              // ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Enter OTP',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  textAlign: TextAlign.center,
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
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                      ],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  // timer
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      // pastedTextStyle: TextStyle(
                      //   color: Colors.green.shade600,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      length: 6,
                      //obscureText: true,
                      // obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (value) {},
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(4),
                          fieldHeight: 48,
                          fieldWidth: 43.5,
                          activeColor: mainColor,
                          selectedColor: mainColor,
                          inactiveColor: mainColor,
                          errorBorderColor: Colors.red),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: textEditingController,
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
                      // beforeTextPaste: (text) {
                      //   debugPrint("Allowing to paste $text");
                      //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      //   return true;
                      // },
                    )),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells " : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: // auth button
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                // ignore: sort_child_properties_last
                child: ButtonTheme(
                  height: 32,
                  child: 
                  
                  
                  AuthButton(onPressed: (){}, text: 'Verify code')
                  
                  
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Resend code",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}






// https://pub.dev/packages/pin_code_fields 