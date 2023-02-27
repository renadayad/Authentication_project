import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String name;
  String? email;
  String? phone;
  String password;
  String? image;

  UserModel({
    this.uid,
    required this.name,
    this.email,
    this.phone,
    required this.password,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'password': ""
      };
}
