import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';

import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/product/widgets/product_option.dart';
import 'package:flutter/material.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({
    super.key,
    required this.nameTab,
    required this.lstCategory,
  });
  final String nameTab;
  final List<Company> lstCategory;

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  String checkCategory = "";
  List<Product> productCompanies = [];
  int id = -1;

  List<dynamic> searchsCompanies(
      int value, List<dynamic> lstData, List<dynamic> lstSearch) {
    lstSearch.clear();
    for (var element in lstData) {
      if (element.company.companyID == value) {
        lstSearch.add(element);
      }
    }
    return lstSearch;
  }

  Future<void> checkOption(String value) async {
    checkCategory = value;
    CompanyAPI.instance.getCompanyId(value).then((valueId) {
      setState(() {
        id = valueId;
        searchsCompanies(id, productCompanies, productCompanies);
      });
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
            ProductOption(lstCompany: widget.lstCategory, onTap: checkOption),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2.2,
                  ),
                  itemCount: productCompanies.length,
                  itemBuilder: (_, index) {
                    return ProductItem(product: productCompanies[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ProductPresenter.instance.getLatestProduct().then((value) {
      setState(() {
        productCompanies = value;
      });
    });
  }
}
