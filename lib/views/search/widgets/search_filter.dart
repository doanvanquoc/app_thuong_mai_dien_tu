import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/presenters/company_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_option.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/filter_option.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchFilter extends StatefulWidget {
  SearchFilter(
      {super.key,
      required this.checkOptioin,
      required this.checkSort,
      required this.checkRate,
      required this.applyOption,
      required this.priceFT});
  Function checkOptioin;
  Function checkSort;
  Function checkRate;
  Function applyOption;
  Function priceFT;
  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  final companyPresenter = CompanyPresenter.instance;
  List<Company> companies = [];

  bool checkrReOrder = false;
  bool checkrRateOption = false;

  @override
  void initState() {
    companyPresenter.getAllCompany().then((value) {
      if (mounted) {
        setState(() {
          companies = value;
        });
      }
    });
    super.initState();
  }

  List<Company> sort = [
    Company(companyID: 1, companyName: 'Mới nhất'),
    Company(companyID: 2, companyName: 'Phổ biến'),
  ];

  List<String> ratelst = [
    '5',
    '4',
    '3',
    '2',
    '1',
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.secondaryColor,
              ),
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
                    checkOptioin: widget.checkOptioin,
                    check: checkrReOrder,
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColor.secondaryColor),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Column(
                            children: [
                              RangeSlider(
                                mouseCursor: MaterialStateMouseCursor.clickable,
                                activeColor: AppColor.primaryColor,
                                min: 1,
                                max: 100,
                                values: rangeValues,
                                onChanged: (value) {
                                  if (mounted) {
                                    setState(() {
                                      checkrReOrder = false;
                                      rangeValues = value;
                                      widget.priceFT(rangeValues.start.toInt(),
                                          rangeValues.end.toInt());
                                    });
                                  }
                                },
                                divisions: 100,
                                labels: RangeLabels(
                                  rangeValues.start.toInt().toString(),
                                  rangeValues.end.toInt().toString(),
                                ),
                              ),
                              Text(
                                'khoảng giá ${rangeValues.start.toInt()} tr -- ${rangeValues.end.toInt()} tr',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColor.secondaryColor,
                                ),
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
                    checkOptioin: widget.checkSort,
                    check: checkrReOrder,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Đánh giá',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReviewOption(
                    lst: ratelst,
                    onTap: widget.checkRate,
                    check: checkrRateOption,
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
                    if (mounted) {
                      setState(() {
                        rangeValues = const RangeValues(10, 20);
                        checkrReOrder = true;
                      });
                    }
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
                      widget.priceFT(
                          rangeValues.start.toInt(), rangeValues.end.toInt());
                      widget.applyOption();
                      Navigator.pop(context);
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
