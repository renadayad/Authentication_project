import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Core/routes/routes.dart';
import '../../../Auth/logic/controller/auth_controller.dart';

class ProfileController extends GetxController {
  final TextEditingController passController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController updateNameController = TextEditingController();
  final controller = Get.find<AuthController>();
  String name = '';
  String image = '';
  final imagePicker = ImagePicker();
  File? pickedFile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNameField();
    getImageField();
  }

  changePassword(
      {required String oldPassword, required String newPassword}) async {
    final user = await FirebaseAuth.instance.currentUser;
    // you should check here that email is not empty
    final credential = await EmailAuthProvider.credential(
      email: user!.email!,
      password: oldPassword,
    );
    try {
      await user.reauthenticateWithCredential(credential).then((value) {
        try {
          FirebaseAuth.instance.currentUser!
              .updatePassword(newPassController.text)
              .whenComplete(() {
            Get.dialog(
              Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.topRight,
              ),
            ).whenComplete(() => Get.back());
            Get.snackbar("title", "successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.white,
                colorText: Colors.white);
          });
        } catch (error) {
          Get.snackbar(
            'Error!',
            error.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[400],
            colorText: Colors.white,
          );
        }
      });
      // proceed with password change
    } on FirebaseAuthException catch (e) {
      // handle if reauthenticatation was not successful
      Get.snackbar(
        'Invalid Password',
        'Chack current password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }

  Future getNameField() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        var docData = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        name = docData['name'];
        update();
      } else {
        return '';
      }
    } catch (error) {
      print(error);
    }
  }

  Future getImageField() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        var docData = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        image = docData['image'];
        update();
      } else {
        return '';
      }
    } catch (error) {
      print(error);
    }
  }

  Future updateName(String updateName) async {
    var user = FirebaseAuth.instance.currentUser;
    user?.updateProfile(displayName: updateName).then((value) {
      print("Profile has been changed successfully");
      final docData = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"name": updateName}).whenComplete(() {
        name = updateName;
        update();
        updateNameController.clear();
      });
    }).catchError((e) {
      print("There was an error updating profile");
    });
  }


  Future<void> TakePhoto(ImageSource sourse) async {
    final pickedImage =
    await imagePicker.pickImage(source: sourse, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    print("..............");
    print(pickedFile);
    print("..............");



    final ref =   FirebaseStorage.instance.ref().child("productImage").child("${FirebaseAuth.instance.currentUser!.uid}" + ".jpg");
    if (pickedFile == null) {
    } else {
      await ref.putFile(pickedFile!);
      image = await ref.getDownloadURL();
    }



    final docProduct = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    docProduct.update({

      'image': image.toString(),
    }).whenComplete(() {
      print("update done");
      Get.snackbar("", "Update successfully..");
      // clearController();
      update();
      // Get.toNamed(Routes.stockScreen);
    });

  }








  void signOut() async {
    try {
      await controller.auth.signOut();
      await controller.googleSign.signOut();
      controller.isSignedIn = false;
      controller.authBox.remove("auth");
      image = "";
      name ="";
      update();
      Get.offNamed(Routes.loginScreen);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }

  void clearController() {
    passController.clear();
    newPassController.clear();
    rePasswordController.clear();
  }
}
