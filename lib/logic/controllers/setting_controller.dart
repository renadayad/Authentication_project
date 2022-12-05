import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'auth_controller.dart';

class SettingController extends GetxController {

  AuthController authController=Get.find();
  GoogleSignIn googleSign = GoogleSignIn(scopes: ['email']);
  final ref =FirebaseStorage.instance.ref().child("profileImage").child("${DateTime.now()}"+'.jpg');


  @override
  void onInit() async {
    await getImageFeild();
   await getNameField();
   await getDescriptionFeild();


    super.onInit();
  }

  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  File? image;
  String? imagePath;
  RxString imagePath1="".obs;
  RxString description="".obs;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
      saveImageInStorage();
      print(imagePath);
      update();
    } else {
      print('No image selected.');
    }
  }

  saveImageInStorage() async {
    try {
      await ref.putFile(image!);
      imagePath = await ref.getDownloadURL();
      print(imagePath);
      DocumentReference doc = FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value);

      // await doc.update({"image": imagePath}).whenComplete(() =>
      // imagePath== null );
      // print(imagePath);
       authController.displayUserPhoto.value=imagePath!;

    } catch (error) {

      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }


   getImageFeild() async {


    if(authController.displayUserPhoto.value!= null){
      var doc1 = await FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value)
          .get();
      authController.displayUserPhoto.value = doc1['image'];
      print("display image in controller ${ authController.displayUserPhoto.value }");

      return authController.displayUserPhoto.value;


    } else { final GoogleSignInAccount? googleUser = await googleSign.signIn();

    return authController.displayUserPhoto.value=googleUser!.photoUrl! ;}

  }

  Future getNameField() async {
    if (authController.displayUserName.value!= null){
      var docData = await FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value)
          .get();
      authController.displayUserName.value = docData['displayName'];
      return authController.displayUserName.value;
    }

    else { final GoogleSignInAccount? googleUser = await googleSign.signIn();

      return authController.displayUserName.value=googleUser!.displayName! ;}

  }

  Future getDescriptionFeild() async {


    if(authController.displayDescription.value.isNotEmpty || authController.displayDescription.value==""){
      var doc1 = await FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value)
          .get();
      authController.displayDescription.value = doc1["description"];

      print("display description ${authController.displayDescription.value}");

      return authController.displayDescription.value;

    }else{
      return "";
    }


  }
}
