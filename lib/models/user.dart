import 'package:app_thuong_mai_dien_tu/models/address.dart';

class User {
  int userID;
  final String email;
  final String fullname;
  final String birthday;
  final String phoneNumber;
  final String avatar;
  final String sex;
  final List<Address>? address;

  User(
      {required this.userID,
      required this.email,
      required this.fullname,
      required this.birthday,
      required this.phoneNumber,
      required this.avatar,
      required this.sex,
      this.address});

  User.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        email = json['email'] ?? '',
        fullname = json['fullname'] ?? '',
        birthday = json['birthday'].toString(),
        phoneNumber = json['phone_number'].toString(),
        avatar = json['avatar'] ?? '',
        sex = json['sex'] ?? '',
        address = List.from(
            (json['addresses'] as List).map((e) => Address.fromJson(e)));
}
