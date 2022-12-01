import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isVisibilty = false;
  bool isCheckBox = false;
  bool isVisibilty2 = false;
  late TabController tabController;
  var displayUserName = '';

  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);
  var isSignedIn = false;
  final GetStorage authBox = GetStorage();
  var authState = ''.obs;
  String verificationId = '';

  Timer? timer;
  int remainSec = 1;
  final time = '00:00'.obs;
  var isbuttonDisable = false;

  void onInit() {
    tabController = TabController(length: 2, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    startTimer(120);
    super.onReady();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  void Visibilty() {
    isVisibilty = !isVisibilty;
    update();
  }

  void Visibilty2() {
    isVisibilty2 = !isVisibilty2;
    update();
  }

  void CheckBox() {
    isCheckBox = !isCheckBox;
    update();
  }

  void loginUsingFierbase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName = name;
        auth.currentUser!.updateDisplayName(name);
      });

      isSignedIn = true;
      authBox.write("auth", isSignedIn);
      update();
      Get.offNamed(Routes.settingScreen);
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'Wrong E-mail') {
        message = 'Wrong E-mail';
      } else if (error.code == 'wrong-password') {
        message = 'Wrong password ';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(title, message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
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
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (e.code == 'user-not-found') {
        message = "No user found for that $email";
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }

  void loginUsinggoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication signInAuthentication =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: signInAuthentication.idToken,
            accessToken: signInAuthentication.accessToken);
        await auth.signInWithCredential(credential);
      }
      displayUserName = googleUser!.displayName!;
      isSignedIn = true;

      update();
      authBox.write("auth", isSignedIn);

      Get.offNamed(Routes.settingScreen);
    } catch (error) {
      Get.snackbar('Error!', error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      await googleSign.signOut();
      displayUserName = "";
      displayUserPhoto.value = '';
      isSignedIn = false;
      authBox.remove("auth");
      update();
      Get.offNamed(Routes.loginScreen);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }

  void signUpUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      update();
      Get.offNamed(Routes.settingScreen);
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'email-already-in-use') {
        message = 'Email already used';
      } else {
        message = e.message.toString();
      }

      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }

  verifyPhone({required String phone, required String password}) async {
    try {
      await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 40),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {},
        verificationFailed: (error) {
          String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
          String message = '';
          if (error.code == 'invalid-phone-number') {
            message = 'No user found for that phone Number.';
          } else if (error.code == 'wrong-password') {
            message = 'Wrong Password ';
          } else {
            message = error.message.toString();
          }
          Get.snackbar(title, message,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        },
        codeSent: (String id, int? resendToken) {
          this.verificationId = id;
          authState.value = "login Success";
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verificationId = id;
        },
      );
    } catch (error) {
      Get.snackbar('Error!', error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  verifyOTP(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp));

      if (credential.user != null) {
        Get.toNamed(Routes.settingScreen);
      }
    } catch (error) {
      Get.snackbar('Error !', error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  reSendOTP({required String phone}) async {
    try {
      await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {},
        verificationFailed: (error) {
          String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
          String message = '';
          if (error.code == 'user-not-found') {
            message = 'No user found for that phone Number.';
          } else {
            message = error.message.toString();
          }
          Get.snackbar(title, message,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        },
        codeSent: (String id, int? resendToken) {
          this.verificationId = id;
          authState.value = "Resend Success";
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verificationId = id;
        },
      );
    } catch (error) {
      Get.snackbar('Error!', error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> googleSignUpApp() async {
    try {
      final googleUser = await googleSign.signIn();

      isSignedIn = true;
      update();
      Get.offNamed(Routes.settingScreen);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }

  void startTimer(int sec) {
    const duration = Duration(seconds: 1);
    remainSec = sec;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainSec == 0) {
        timer.cancel();
        buttonDisable();
      } else {
        int min = remainSec ~/ 60;
        int sec = (remainSec % 60);
        time.value = min.toString().padLeft(2, '0') +
            ':' +
            sec.toString().padLeft(2, '0');
        remainSec--;
        
      }
    });
  }

  void buttonDisable() {
    isbuttonDisable = !isbuttonDisable;
    update();
  }
}
