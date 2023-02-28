class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? image;

  UserModel(
      {this.uid, this.name, this.email, this.phone, this.password, this.image});

  UserModel.fromData(Map<String, dynamic>? dataMap)
      : uid = dataMap!['id'],
        name = dataMap['name'],
        email = dataMap['email'],
        phone = dataMap['phone'],
        password = dataMap['password'],
        image = dataMap['image'];

  Map<String, dynamic> toData() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'image': image,
    };
  }
}
