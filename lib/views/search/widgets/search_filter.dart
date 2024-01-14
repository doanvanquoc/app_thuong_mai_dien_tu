import 'package:app_thuong_mai_dien_tu/models/category.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/rate/widgets/rate_option.dart';
import 'package:app_thuong_mai_dien_tu/views/search/widgets/filter_option.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<Category> categorylst = [
    Category("Apple", true),
    Category("Iphone", true),
    Category("Samsung", true),
    Category("Xiaomi", true),
    Category("Apple", true),
    Category("Iphone", true),
    Category("Samsung", true),
    Category("Xiaomi", true),
  ];
  List ratelst = ['Tất cả', '5', '4', '3', '2', '1'];

  List<Category> sort = [
    Category("Phổ biến", true),
    Category("Gần đây", true),
    Category("Giá cao", true),
    Category("Giá thấp", true),
  ];

  RangeValues rangeValues = const RangeValues(10, 90);
  String checkCategory = "";
  void checkOption(value) {
    setState(() {
      checkCategory = value;
      print(checkCategory);
    });
  }

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
            height: MediaQuery.of(context).size.height / 1.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOption(
                    lst: categorylst,
                    nameOption: "Phân loại",
                    onTap: checkOption,
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
                                min: 0,
                                max: 100,
                                values: rangeValues,
                                onChanged: (value) {
                                  setState(() {
                                    rangeValues = value;
                                    print(rangeValues);
                                  });
                                },
                                divisions: 100,
                                labels: RangeLabels(
                                  rangeValues.start.round().toString(),
                                  rangeValues.end.round().toString(),
                                ),
                              ),
                              Text(
                                'khoảng giá ${rangeValues.start} tr -- ${rangeValues.end} tr',
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
                    onTap: checkOption,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Đánh giá',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  RateOption(
                    lst: ratelst,
                    onTap: checkOption,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyButton(
                    onTap: () {},
                    content: 'Đặt lại',
                    backgroundColor: const Color(0xFFe4faf0),
                    textColor: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyButton(onTap: () {}, content: "Áp dụng"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
