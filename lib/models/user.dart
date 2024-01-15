class User {
  final int userID;
  final String email;
  final String fullname;
  final String birthday;
  final String phoneNumber;
  final String avatar;

  User({
    required this.userID,
    required this.email,
    required this.fullname,
    required this.birthday,
    required this.phoneNumber,
    required this.avatar,
  });

  User.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        email = json['email'],
        fullname = json['fullname'],
        birthday = json['birthday'],
        phoneNumber = json['phone_number'],
        avatar = json['avatar'];
}
