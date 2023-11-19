class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    uId = json["uId"];
    uId = json["image"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}