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
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2.2,
                  ),
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProductDetail()));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 200,
                                child: Image.asset(
                                  'assets/images/phone2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Iphone 15 Pro Max 8G/ 128GB - VN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_border,
                                    color: Color(0xFF01B763),
                                  ),
                                  const Text('4.5'),
                                  const SizedBox(width: 10),
                                  const Text('|'),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF01B763)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      '3000 đã bán',
                                      style:
                                          TextStyle(color: Color(0xFF01B763)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              '32.900.000đ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF01B763),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
