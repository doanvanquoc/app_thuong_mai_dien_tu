// ignore_for_file: public_member_api_docs, sort_constructors_first
class Status {
  final int statusID;
  final String status;
  Status({
    required this.statusID,
    required this.status,
  });

  Status.fromJson(Map<String, dynamic> json)
      : statusID = json['statusID'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    return {'statusID': statusID, 'status': status};
  }
}
