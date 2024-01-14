class Product {
  final String image;
  final String name;
  final String description; //mô tả bên chi tiết
  final String price;
  int quantity;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity});
}

///bên dưới 

// import 'dart:convert';
// import 'package:app_thuong_mai_dien_tu/models/image.dart';
// import 'package:http/http.dart' as http;
// class Product {
//   final int productID;
//   final String productName;
//   final int price;
//   final String description;
//   int quantity;
//   final double screenSize;
//   final String os;
//   final String cpu;
//   final int ram;
//   final int internalStorage;
//   final int mainCamResolution;
//   final int frontCamResolution;
//   final int battery;
//   final int weight;
//   final String postDate;
//   final int companyID;
//   final List<ImageI> images;

//   Product(
//       this.productID,
//       this.productName,
//       this.price,
//       this.description,
//       this.quantity,
//       this.screenSize,
//       this.os,
//       this.cpu,
//       this.ram,
//       this.internalStorage,
//       this.mainCamResolution,
//       this.frontCamResolution,
//       this.battery,
//       this.weight,
//       this.postDate,
//       this.companyID,
//       this.images);
//   static List<Product> productList = [];

//   Product.fromJson(Map<String, dynamic> json)
//       : productID = json['productID'],
//         productName = json['product_name'],
//         price = json['price'],
//         description = json['description'],
//         quantity = json['quantity'],
//         screenSize = json['screen_size'],
//         os = json['os'],
//         cpu = json['cpu'],
//         ram = json['ram'],
//         internalStorage = json['internal_storage'],
//         mainCamResolution = json['main_cam_resolution'],
//         frontCamResolution = json['front_cam_resolution'],
//         battery = json['battery'],
//         weight = json['weight'],
//         postDate = json['post_date'],
//         companyID = json['companyID'],
//         images = (json['images'] as List<dynamic>)
//             .map((json) => ImageI.fromJson(json))
//             .toList();

//   static String baseUrl = 'https://api.vanquoc.id.vn/product/news';
//   static Future<void> getAllProdcut() async {
//     try {
//       var response = await http.get(Uri.parse(baseUrl));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> mapData = jsonDecode(response.body);
//         List<dynamic> jsonProduct = mapData['data'];
//         for (var item in jsonProduct) {
//           productList.add(Product.fromJson(item));
//         }
//       } else {
//         return Future.error("Sever error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }
