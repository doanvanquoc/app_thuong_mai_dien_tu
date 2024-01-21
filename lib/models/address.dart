class Address {
  int? addressID;
  String name;
  String address;
  bool? isDefault;
  int? userID;

  Address({
    this.addressID,
    required this.name,
    required this.address,
    this.isDefault,
    this.userID,
  });

  Address.fromJson(Map<String, dynamic> json)
      : addressID = json['addressID'],
        name = json['name'],
        address = json['address'],
        userID = json['userID'] ?? 1;

  static Address? getDefaultAddress(List<Address> addresses) {
    if (addresses.isEmpty) {
      return null;
    }
    try {
      return addresses.firstWhere((address) => address.isDefault == true);
    } catch (e) {
      return addresses.first;
    }
  }
}
