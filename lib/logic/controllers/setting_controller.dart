


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'auth_controller.dart';


class SettingController extends GetxController {
  AuthController authController=Get.find();
  final ref =FirebaseStorage.instance.ref().child("profileImage").child("${DateTime.now()}"+'.jpg');

  @override
  void onInit() {

    super.onInit();
  }
  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  File? image;
  String? imagePath;
  String? imagePath1;
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
  
  saveImageInStorage() async{
    try{
      await ref.putFile(image!);
      imagePath=await ref.getDownloadURL();
      print(imagePath);
      DocumentReference doc = FirebaseFirestore.instance
          .collection("users")
          .doc(authController.displayUserEmail.value);
      await doc.update({"image": imagePath});
      print(imagePath);

    }catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }

  }

  Future getImageFeild() async {
    var doc1 = await FirebaseFirestore.instance
        .collection("users")
        .doc(authController.displayUserEmail.value)
        .get();
    imagePath = doc1["image"];
    print("display image ${imagePath}");
    imagePath1=imagePath;

    return imagePath1;
  }




}