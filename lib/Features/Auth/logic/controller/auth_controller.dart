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

  var isSignedIn = false;
  final GetStorage authBox = GetStorage();
  bool isCheckBox = false;

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
  void CheckBox() {
    isCheckBox = !isCheckBox;
    update();
    if (isCheckBox) {
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController.text =
        GetStorage().read("email") == null ? '' : GetStorage().read("email");
    isCheckBox = GetStorage().read("checKBox") == null
        ? false
        : GetStorage().read("checKBox");
  }

  // *************Sgin up with email*****************
  void signUpUsingFirebase({required UserModel userModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.password.toString())
          .then((value) {
        final fierbaseStoreRefrence =
            FirebaseFirestore.instance.collection("users").doc(userModel.email);
        final data = userModel.toJson();
        fierbaseStoreRefrence.set(data).whenComplete(() {
          update();
          clearController();
          Get.snackbar("", "Add successfully");
          isSignedIn = false;
          authBox.remove("auth");
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

  verifyOTP(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp));

      if (credential.user != null) {
        Get.offNamed(Routes.settingsScreen);
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



  // clear Controller
  void clearController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }

  //#####################################################################

  final Rx<UserModel> _userModel =
      UserModel(email: '', name: '', uid: '', password: '', image: '').obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  var displayDescription = ''.obs;

  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get userProfile => auth.currentUser;

  // @override
  // void onReady() {
  //   startTimer(60);
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  //   super.onClose();
  // }

  loginUsingFierbase({
    required String email,
    required String password,
  }) async {
    try {
      print("in auth $email");
      print("in auth controller var $displayUserEmail");
      print("in auth controller var $displayUserName");
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(displayUserEmail.value)
            .get();
        Map<String, dynamic> docData = userDoc.data() as Map<String, dynamic>;
        displayUserName.value = docData['displayName'];
        displayUserEmail.value = docData['email'];
        displayDescription.value = docData['description'];
        displayUserPhoto.value = docData['image'];
      });

      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return CircularProgressIndicator();
      //   },
      // );

      isSignedIn = true;
      authBox.write("auth", isSignedIn);
      update();
      Get.offNamed(Routes.profileScreen);
      //getEmailDoc();
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

  Future<void> loginUsinggoogle() async {
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
      displayUserName.value = googleUser!.displayName!;
      displayUserName.value =
          (userProfile != null ? userProfile!.displayName : "") ?? "";
      displayUserEmail.value = googleUser.email;
      displayUserPhoto.value = googleUser.photoUrl!;

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

  void signOut() async {
    try {
      await auth.signOut();
      await googleSign.signOut();
      displayUserName.value = "";
      displayUserPhoto.value = '';
      displayUserEmail.value = '';
      displayDescription.value = '';
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

  // Future<void> googleSignUpApp() async {
  //   try {
  //     final googleUser = await googleSign.signIn();

  //     isSignedIn = true;
  //     update();
  //     Get.offNamed(Routes.profileScreen);
  //   } catch (error) {
  //     Get.snackbar(
  //       'Error!',
  //       error.toString(),
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red[400],
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future updateFields(TextEditingController value, TextEditingController value1,
      String imageUrl) async {
    try {
      // value is the email user inputs in a textfield and is validated
      DocumentReference doc = FirebaseFirestore.instance
          .collection("users")
          .doc(displayUserEmail.value);
      if (value.text.isNotEmpty) {
        await doc.update({"displayName": value.text});
        displayUserName.value = value.text;
      }
      if (value1.text.isNotEmpty) {
        await doc.update({"description": value1.text});
        displayDescription.value = value1.text;
      }
      if (imageUrl.isNotEmpty) {
        await doc.update({"image": imageUrl});
        displayUserPhoto.value = imageUrl;
      }
      print(displayUserEmail.value);

      Get.snackbar(
        'Success!',
        "Updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
      );
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

  Future getUserFromDB(String uid) async {
    try {
      var userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      var map = userData.data();
      //debugPrint(map!['email']);

    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
