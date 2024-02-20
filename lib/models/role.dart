// ignore_for_file: public_member_api_docs, sort_constructors_first
class Role {
  final int roleID;
  final String role;
  Role({
    required this.roleID,
    required this.role,
  });

  Role.fromJson(Map<String, dynamic> json)
      : roleID = json['roleID'],
        role = json['role'];
}
