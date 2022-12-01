class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.image
  });

  UserModel.fromData(Map<String, dynamic>? dataMap)
      : uid = dataMap!['id'],
        name = dataMap['name'],
        email = dataMap['email'],
        password = dataMap['password'],
        image = dataMap['image'];



  Map<String, dynamic> toData() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image,

    };
  }
}