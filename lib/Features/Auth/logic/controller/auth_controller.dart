import 'dart:async';
import 'package:auth_app/Features/Auth/view/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../Common/models/UserModel.dart';
import '../../../../Core/routes/routes.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final GetStorage authBox = GetStorage();
  var isSignedIn = false;
  bool isCheckBoxEmail = false;
  bool isCheckBoxPhone = false;
  bool isVisibiltyPassword = false;
  bool isVisibiltyRePassword = false;
  var isButtonDisableResendCode = false;
  var isButtonDisableVerifyCode = true;
  void VisibiltyPassword() {
    isVisibiltyPassword = !isVisibiltyPassword;
    update();
  }

  void VisibiltyRePassword() {
    isVisibiltyRePassword = !isVisibiltyRePassword;
    update();
  }

  void buttonDisableResendCode() {
    isButtonDisableResendCode = !isButtonDisableResendCode;
    update();
  }

  void buttonDisableVerifyCode() {
    isButtonDisableVerifyCode = !isButtonDisableVerifyCode;
    update();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    emailController.text =
        GetStorage().read("email") == null ? '' : GetStorage().read("email");

    phoneNumberController.text =
        GetStorage().read("phone") == null ? '' : GetStorage().read("phone");
  }

  void CheckBoxEmail() {
    isCheckBoxEmail = !isCheckBoxEmail;
    update();
    if (isCheckBoxEmail) {
      GetStorage().write("email", emailController.text);
      emailController.text = GetStorage().read("email");
      GetStorage().write("checKBox", true);
    } else {
      emailController.text = '';
      passwordController.text = '';
      GetStorage().write("email", emailController.text);
      GetStorage().write("checKBox", false);
    }
  }

  void CheckBoxPhone() {
    isCheckBoxPhone = !isCheckBoxPhone;
    update();
    if (isCheckBoxPhone) {
      GetStorage().write("phone", phoneNumberController.text);
      phoneNumberController.text = GetStorage().read("phone");
      GetStorage().write("checKBoxPhone", true);
    } else {
      phoneNumberController.text = '';
      passwordController.text = '';
      GetStorage().write("phone", phoneNumberController.text);
      GetStorage().write("checKBoxPhone", false);
    }
  }

  // *************Sgin up with email*****************
  void signUpUsingFirebase({required UserModel userModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.password.toString())
          .then((value) {
        update();
        clearController();
        isSignedIn = false;
        Get.offNamed(Routes.loginScreen);
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  // *************login with email*****************
  loginUsingFierbase({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        isSignedIn = true;
        authBox.write("auth", isSignedIn);
        if (isCheckBoxEmail) {
          emailController.text = GetStorage().read("email");
        } else {
          emailController.clear();
        }
        update();
        clearController();
        Get.snackbar("", "login successfully");
        Get.offNamed(Routes.profileScreen);
      });
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  // ************* Sgin in with phone number and otp function*****************

  String verificationId = '';
  Timer? timer;
  int remainSec = 1;
  var time = '00:00'.obs;
  verifyPhone({required String phone}) {
    try {
      auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: "+966" + phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          Get.snackbar(
            'Error!',
            error.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
          );
        },
        codeSent: (String id, int? resendToken) {
          this.verificationId = id;
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verificationId = id;
        },
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  verifyOTP(String otp) async {
    try {
      var credential = await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp))
          .whenComplete(() {
        clearController();
        isSignedIn = false;
      });
      if (credential.user != null) {
        isSignedIn = true;
        update();
        authBox.write("auth", isSignedIn);
        Get.offNamed(Routes.profileScreen);
      }
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      // isSignedIn = false;
      Get.to(OTPScreen(phonenumber: phoneNumberController.text));
    }
  }

  reSendOTP({required String phoneNumber}) async {
    verifyPhone(phone: phoneNumber);
    update();
  }

  void startTimer(int sec) {
    const duration = Duration(seconds: 1);
    remainSec = sec;
    timer = Timer.periodic(duration, (timer) {
      if (remainSec == 0) {
        timer.cancel();

        buttonDisableResendCode();
        buttonDisableVerifyCode();
      } else {
        int min = (remainSec ~/ 60);
        int sec = (remainSec % 60);
        time.value = min.toString().padLeft(2, '0') +
            ':' +
            sec.toString().padLeft(2, '0');
        remainSec--;
      }
    });
  }

  //***************Sign in with google***************************
  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);
  Future<void> loginUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication signInAuthentication =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: signInAuthentication.idToken,
            accessToken: signInAuthentication.accessToken);
        await auth.signInWithCredential(credential).whenComplete(() {
          isSignedIn = true;
          update();
          authBox.write("auth", isSignedIn);
          Get.offNamed(Routes.profileScreen);
        });
      } else {
        return;
      }
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  // clear Controller
  void clearController() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }
}
