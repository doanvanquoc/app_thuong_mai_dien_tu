import 'package:app_thuong_mai_dien_tu/data_sources/repo/address_api.dart';
import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'dart:developer';

class AddressPresenter {
  AddressPresenter._internal();
  static final AddressPresenter instance = AddressPresenter._internal();
  final api = AddressAPI.instance;

  Future<List<Address>> getUserAddresses(int userID) async {
    return await api.getUserAddresses(userID);
  }

  Future<bool> addNewAddress(int userID, String address) async {
    try {
      Address? newAddress = await api.addAddress(userID, address);
      return newAddress != null;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
