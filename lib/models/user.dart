class User {
  int userID;
  final String email;
  final String fullname;
  final String birthday;
  final String phoneNumber;
  final String avatar;
  final String sex;

  User(
      {required this.userID,
      required this.email,
      required this.fullname,
      required this.birthday,
      required this.phoneNumber,
      required this.avatar,
      required this.sex});

  User.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        email = json['email'] ?? '',
        fullname = json['fullname'] ?? '',
        birthday = json['birthday'].toString(),
        phoneNumber = json['phone_number'].toString(),
        avatar = json['avatar'] ?? '',
        sex = json['sex'] ?? '';
}
