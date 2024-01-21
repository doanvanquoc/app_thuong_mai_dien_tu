import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_item_specificatioin.dart';
import 'package:flutter/material.dart';

class DetailSpecifications extends StatefulWidget {
  const DetailSpecifications({super.key, required this.product});
  final Product product;
  @override
  State<DetailSpecifications> createState() => _DetailSpecificationsState();
}

class _DetailSpecificationsState extends State<DetailSpecifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Thông số kỹ thuật',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          DetailItemSpecification(
            nameItem: 'Kích thước màn hình ${widget.product.screenSize} inches',
            check: true,
          ),
          DetailItemSpecification(
            nameItem: 'Camera sau ${widget.product.mainCamResolution} MP',
          ),
          DetailItemSpecification(
            nameItem: 'Camera trước ${widget.product.frontCamResolution} MP',
            check: true,
          ),
          DetailItemSpecification(
            nameItem: 'Chipset ${widget.product.cpu}',
          ),
          DetailItemSpecification(
            nameItem: 'Dung lượng RAM ${widget.product.ram} GB',
            check: true,
          ),
          DetailItemSpecification(
            nameItem: 'Bộ nhớ trong ${widget.product.internalStorage} GB',
          ),
          DetailItemSpecification(
            nameItem: 'Pin ${widget.product.battery}  mAh',
            check: true,
          ),
          DetailItemSpecification(
            nameItem: 'Hệ điều hành ${widget.product.os}',
          ),
          DetailItemSpecification(
            nameItem: 'Trọng lượng ${widget.product.weight} g',
            check: true,
          ),
        ],
      ),
    );
  }
}
