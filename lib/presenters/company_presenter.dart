import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';

class CompanyPresenter {
  CompanyPresenter._internal();
  static final CompanyPresenter instance = CompanyPresenter._internal();

  final api = CompanyAPI.instance;

  Future<List<Company>> getAllCompany() async {
    try {
      List<Company> companies = await api.getAllCompany();
      return companies;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
