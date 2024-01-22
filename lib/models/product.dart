import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/image.dart';
import 'package:intl/intl.dart';

class Product {
  final int productID;
  final String productName;
  final int price;
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
  final String totalSell;
  final num avgRating;
  final List<Image> images;
  Product(this.avgRating,
      {required this.productID,
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
      required this.totalSell,
      required this.images});

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
        totalSell = json['TongBan'] ?? '0',
        avgRating = json['avg_rating'] ?? 0,
        images =
            List.from((json['images'] as List).map((e) => Image.fromJson(e)));

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'product_name': productName,
      'price': price,
      'description': description,
      'quantity': quantity,
      'company': company.toJson(),
      'screen_size': screenSize,
      'os': os,
      'cpu': cpu,
      'ram': ram,
      'internal_storage': internalStorage,
      'main_cam_resolution': mainCamResolution,
      'front_cam_resolution': frontCamResolution,
      'battery': battery,
      'weight': weight,
      'post_date': postDate,
      'TongBan': totalSell,
      'avg_rating': avgRating,
      'images': images.map((e) => e.toJson()).toList(),
    };
  }

  static String formatPrice(String price) {
    num priceNum = num.parse(price);
    final numberFormat = NumberFormat('#,##0', 'vi_VN');
    return '${numberFormat.format(priceNum)} VNĐ';
  }

  static int parsePrice(String price) {
    String numericString = price.replaceAll('VNĐ', '').replaceAll('.', '');
    return int.tryParse(numericString) ?? 0;
  }
}
