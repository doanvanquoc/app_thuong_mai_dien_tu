import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DetailItemSpecification extends StatelessWidget {
  const DetailItemSpecification(
      {super.key, required this.nameItem, this.check = false});
  final String nameItem;
  final bool check;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
        color: check ? const Color(0xfff2f2f2) : const Color(0xffffffff),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          nameItem,
          style: const TextStyle(fontSize: 16, color: AppColor.secondaryColor),
        ),
      ),
    );
  }
}
