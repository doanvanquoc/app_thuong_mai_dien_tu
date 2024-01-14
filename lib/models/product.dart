import 'package:app_thuong_mai_dien_tu/data_sources/repo/product_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/image.dart';

class Product {
  final int productID;
  final String productName;
  final num price;
  final String description;
  final int quantity;
  final Company company;
  final num screenSize;
  final String os;
  final String cpu;
  final int ram;
  final int internalStorage;
  final int mainCamResolution;
  final int frontCamResolution;
  final int battery;
  final num weight;
  final String postDate;
  final List<Image> images;
  Product({
    required this.productID,
    required this.productName,
    required this.price,
    required this.description,
    required this.quantity,
    required this.company,
    required this.screenSize,
    required this.os,
    required this.cpu,
    required this.ram,
    required this.internalStorage,
    required this.mainCamResolution,
    required this.frontCamResolution,
    required this.battery,
    required this.weight,
    required this.postDate,
    required this.images
  });

  Product.fromJson(Map<String, dynamic> json)
      : productID = json['productID'],
        productName = json['product_name'],
        price = json['price'],
        description = json['description'],
        quantity = json['quantity'],
        company = Company.fromJson(json['company']),
        screenSize = json['screen_size'],
        os = json['os'],
        cpu = json['cpu'],
        ram = json['ram'],
        internalStorage = json['internal_storage'],
        mainCamResolution = json['main_cam_resolution'],
        frontCamResolution = json['front_cam_resolution'],
        battery = json['battery'],
        weight = json['weight'],
        postDate = json['post_date'],
        images = List.from((json['images'] as List).map((e) => Image.fromJson(e)));
}
