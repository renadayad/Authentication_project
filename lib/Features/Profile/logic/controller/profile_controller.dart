import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final TextEditingController passController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  String name = '';
  String image = '';

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
                //*******
                // child: AlertEditpass(),
                //  **********
              ),
            ).whenComplete(() => Get.back());
            Get.snackbar("title", "successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.white,
                colorText: Colors.white);
            //********
            // clearController();

            //  *****************
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
            .doc(FirebaseAuth.instance.currentUser!.displayName)
            .get();
        name = docData['name'];

        update();
      } else {
        return '';
      }
    } catch (error) {
      print("############################");
      print(error);
    }
  }

  Future getImageField() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        var docData = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.displayName)
            .get();
        image = docData['image'];
        print(docData['image']);

        update();
      } else {
        return '';
      }
    } catch (error) {
      print(error);
    }
  }
}
