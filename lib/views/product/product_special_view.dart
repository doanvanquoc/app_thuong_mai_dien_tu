import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/product/widgets/product_option.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/product_detail_view.dart';
import 'package:flutter/material.dart';

class ProductSpecial extends StatefulWidget {
  const ProductSpecial({
    super.key,
    required this.nameTab,
    required this.lstCategory,
    required this.lstProduct,
  });
  final String nameTab;
  final List lstCategory;
  final List lstProduct;

  @override
  State<ProductSpecial> createState() => _ProductSpecialState();
}

class _ProductSpecialState extends State<ProductSpecial> {
  String checkCategory = "";
  List<String> products = [
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png',
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png',
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png'
  ];
  void checkOption(value) {
    setState(() {
      checkCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameTab),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ProductOption(lst: widget.lstCategory, onTap: checkOption),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2.2,
                  ),
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    return ProductItem(product: products[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
