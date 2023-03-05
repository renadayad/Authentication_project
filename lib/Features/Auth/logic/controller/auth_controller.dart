import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // *************log in with email*****************

  loginUsingFierbase({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        isSignedIn = true;
        // await auth.currentUser!.updateDisplayName(email);
        authBox.write("auth", isSignedIn);
        update();
        clearController();
        if (isCheckBoxEmail) {
          emailController.text = GetStorage().read("email");
        } else {
          emailController.clear();
        }
        Get.snackbar("", "login successfully");

        Get.offNamed(Routes.profileScreen);
      });
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

  // *************Sgin up with email*****************
  void signUpUsingFirebase({required UserModel userModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.password.toString())
          .then((value) {
        final fierbaseStoreRefrence = FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid);
        final data = userModel.toJson();
        fierbaseStoreRefrence.set(data).whenComplete(() {
          update();
          clearController();
          isSignedIn = false;
          //authBox.remove("auth");
          Get.offNamed(Routes.loginScreen);
        });
      });
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

  // *************Sgin up and Sgin in with phone number and otp function*****************

  String verificationId = '';
  Timer? timer;
  int remainSec = 1;
  var time = '00:00'.obs;
  // var isbuttonDisable = false;

  verifyPhone({required String phone, required String password}) {
    try {
      auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: "+966" + phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
          String message = '';
          if (error.code == 'invalid-phone-number') {
            message = 'No user found for that phone Number.';
          } else if (error.code == 'wrong-password') {
            message = 'Wrong Password ';
          } else {
            Get.snackbar('Error!', error.toString(),
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        },
        codeSent: (String id, int? resendToken) {
          this.verificationId = id;
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

  verifyOTP(String otp, UserModel userModel) async {
    try {
      var credential = await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp))
          .whenComplete(() {
        userModel = UserModel(
            name: userModel.name,
            phone: userModel.phone,
            password: "",
            email: "",
            image: "");
        final fierbaseStoreRefrence = FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid);
        final data = userModel.toJson();
        fierbaseStoreRefrence.set(data).whenComplete(() {
          update();
          clearController();
          isSignedIn = true;
          update();
          authBox.write("auth", isSignedIn);
          Get.offNamed(Routes.profileScreen);
        });
      });
      if (credential.user != null) {
        Get.offNamed(Routes.profileScreen);
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
        phoneNumber: "+966" + phone,
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
  Future<void> loginUsinggoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication signInAuthentication =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: signInAuthentication.idToken,
            accessToken: signInAuthentication.accessToken);
        await auth.signInWithCredential(credential).whenComplete(() {
          UserModel userModel = UserModel(
              name: googleUser.displayName.toString(),
              password: '',
              email: googleUser.email,
              image: googleUser.photoUrl,
              phone: '');
          final fierbaseStoreRefrence = FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid);
          final data = userModel.toJson();
          fierbaseStoreRefrence.set(data).whenComplete(() {
            update();
            clearController();
            isSignedIn = false;
            //authBox.remove("auth");
            Get.offNamed(Routes.profileScreen);
          });
        });
      }
      isSignedIn = true;
      update();
      authBox.write("auth", isSignedIn);

      Get.offNamed(Routes.profileScreen);
    } catch (error) {
      Get.snackbar('Error!', error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
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

  void signOut() async {
    try {
      await auth.signOut();
      await googleSign.signOut();
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

  // clear Controller
  void clearController() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }
}
