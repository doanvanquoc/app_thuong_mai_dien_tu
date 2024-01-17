class Address {
  String addressID;
  String address;
  bool? isDefault;
  int? userID;

  Address({
    required this.addressID,
    required this.address,
    this.isDefault,
    this.userID,
  });

  Address.fromJson(Map<String, dynamic> json)
      : addressID = json['addressID'],
        address = json['address'],
        userID = json['userID'];

  static Address? getDefaultAddress(List<Address> addresses) {
    if (addresses.isEmpty) {
      return null;
    }

    try {
      return addresses.firstWhere((address) => address.isDefault == true);
    } catch (e) {
      return null;
    }
  }
}
