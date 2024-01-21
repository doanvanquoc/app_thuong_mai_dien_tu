class Address {
  String name;
  String street;
  bool? isDefault;

  Address({required this.name, required this.street, this.isDefault});

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