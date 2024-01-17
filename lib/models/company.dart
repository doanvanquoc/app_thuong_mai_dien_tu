class Company {
  final int companyID;
  final String companyName;
  Company({
    required this.companyID,
    required this.companyName,
  });

  Company.fromJson(Map<String, dynamic> json)
      : companyID = json['companyID'],
        companyName = json['company_name'];
}
