import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/presenters/company_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_option.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/filter_option.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter(
      {super.key,
      required this.checkOptioin,
      required this.applyOption,
      required this.priceFT});
  Function checkOptioin;
  Function applyOption;
  Function priceFT;
  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  final companyPresenter = CompanyPresenter.instance;
  List<Company> companies = [];
  @override
  void initState() {
    companyPresenter.getAllCompany().then((value) {
      setState(() {
        companies = value;
      });
    });
    super.initState();
  }

  List<Company> sort = [
    Company(companyID: 1, companyName: 'Mới nhất'),
    Company(companyID: 2, companyName: 'Gần nhất'),
    Company(companyID: 1, companyName: 'Mua nhiều nhất'),
  ];

  RangeValues rangeValues = const RangeValues(10, 21);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(40),
        ),
      ),
      height: MediaQuery.of(context).size.height / 1.238,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Bộ lọc",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.63,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOption(
                    lst: companies,
                    nameOption: "Phân loại",
                    onTap: widget.checkOptioin,
                  ),
                  SizedBox(
                    height: 151,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Khoảng giá',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Column(
                            children: [
                              RangeSlider(
                                mouseCursor: MaterialStateMouseCursor.clickable,
                                activeColor: AppColor.primaryColor,
                                min: 3,
                                max: 100,
                                values: rangeValues,
                                onChanged: (value) {
                                  setState(() {
                                    rangeValues = value;
                                    widget.priceFT(rangeValues.start.toInt(),
                                        rangeValues.end.toInt());
                                  });
                                },
                                divisions: 100,
                                labels: RangeLabels(
                                  rangeValues.start.round().toInt().toString(),
                                  rangeValues.end.round().toInt().toString(),
                                ),
                              ),
                              Text(
                                'khoảng giá ${rangeValues.start.toInt()} tr -- ${rangeValues.end.toInt()} tr',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilterOption(
                    lst: sort,
                    nameOption: "Sắp xếp theo",
                    onTap: widget.checkOptioin,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Đánh giá',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ReviewOption(
                    lst: const [],
                    onTap: widget.checkOptioin,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyButton(
                  onTap: () {
                    setState(() {
                      rangeValues = const RangeValues(10, 90);
                    });
                  },
                  content: 'Đặt lại',
                  backgroundColor: const Color(0xFFe4faf0),
                  textColor: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MyButton(
                    onTap: () {
                      widget.applyOption();
                    },
                    content: "Áp dụng"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
