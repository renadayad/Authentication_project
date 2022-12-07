import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/userModel.dart';
import '../../routes.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Rx<UserModel> _userModel =
      UserModel(email: '', name: '', uid: '', password: '', image: '').obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  bool isVisibilty = false;
  bool isCheckBox = false;
  bool isVisibilty2 = false;

  late TabController tabController;
  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  var displayDescription = ''.obs;

  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  var isSignedIn = false;
  final GetStorage authBox = GetStorage();
  User? get userProfile => auth.currentUser;
  var authState = ''.obs;
  String verificationId = '';

  Timer? timer;
  int remainSec = 1;
  var time = '00:00'.obs;
  var isbuttonDisable = false;

  @override
  void onInit() {
    displayUserPhoto.value =
        (userProfile != null ? userProfile!.photoURL : "") ?? "";

    displayUserEmail.value =
        (userProfile != null ? userProfile!.email : "") ?? "";

    tabController = TabController(length: 2, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    startTimer(60);
    super.onReady();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

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

  void signUpUsingFirebase({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName.value = name;
        auth.currentUser!.updateDisplayName(name);
        print(" this is username ${displayUserName.value}");
        print(" this is userprofile ${userProfile!.displayName}");
        displayUserEmail.value = email;
      });

      DocumentReference doc =
          FirebaseFirestore.instance.collection("users").doc(email);

      doc.set({
        "email": email,
        "password": password,
        "displayName": name,
        "image": "",
        "description": "",
      });

      update();
      Get.offNamed(Routes.profileScreen);
      // getEmailDoc();
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


    update();
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

  void startTimer(int sec) {
    const duration = Duration(seconds: 1);
    remainSec = sec;
    timer = Timer.periodic(duration, (timer) {
      if (remainSec == 0) {
        timer.cancel();

        buttonDisable();
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

  void buttonDisable() {
    isbuttonDisable = !isbuttonDisable;
    update();
  }

  Future getUserFromDB(String uid) async {
    try {
      var userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      var map = userData.data();
      //debugPrint(map!['email']);
      return UserModel.fromData(userData.data());
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
