import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/banner_api.dart';
import 'package:app_thuong_mai_dien_tu/models/banner.dart';

class BannerPresenter {
  BannerPresenter._internal();
  static final BannerPresenter instance = BannerPresenter._internal();

  Future<List<Banner>> getBanners() async {
    List<Banner> banners = [];
    try {
      banners = await BannerAPI.instance.getBanners();
      return banners;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
