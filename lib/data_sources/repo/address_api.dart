import 'dart:convert';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class AddressAPI {
  AddressAPI._internal();
  static final AddressAPI instance = AddressAPI._internal();
  final Dio dio = Dio();

  Future<List<Address>> getUserAddresses(int userID) async {
    try {
      final response = await dio.get('${APIConfig.API_URL}/address/$userID');
      if (response.statusCode == 200 && response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Lấy địa chỉ thất bại');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Address?> addAddress(int userID, String address) async {
    try {
      final response = await dio.post(
        '${APIConfig.API_URL}/address/add',
        data: jsonEncode({'userID': userID, 'address': address}),
      );

      if (response.statusCode == 200 && response.data['code'] == 1) {
        return Address.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}