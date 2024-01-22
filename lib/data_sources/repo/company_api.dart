import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:dio/dio.dart';

class CompanyAPI {
  CompanyAPI._internal();
  static final CompanyAPI instance = CompanyAPI._internal();

  final dio = Dio();

  Future<List<Company>> getAllCompany() async {
    List<Company> companies = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/company');
      companies =
          (res.data['data'] as List).map((e) => Company.fromJson(e)).toList();
      return companies;
    } catch (e) {
      log('Lỗi company: $e');
      return [];
    }
  }

  Future<int> getCompanyId(value) async {
    List<Company> companies = await getAllCompany();
    for (var element in companies) {
      if (element.companyName == value) {
        return element.companyID;
      }
    }
    return -1;
  }
}
