import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterSort extends StatefulWidget {
  FilterSort({
    super.key,
    required this.lst,
    required this.nameOption,
    required this.checkSort,
    required this.check,
  });
  final List lst;
  final String nameOption;
  Function checkSort;
  bool check;

  @override
  State<FilterSort> createState() => _FilterSortState();
}

class _FilterSortState extends State<FilterSort> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.check) {
      selectedIndex = -1;
      widget.check = false;
    }
    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.nameOption,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.lst.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIndex == index) {
                          selectedIndex = -1;
                          widget.checkSort('');
                        } else {
                          selectedIndex = index;
                          widget.checkSort(widget.lst[index]);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColor.primaryColor
                            : Colors.white,
                        border: Border.all(
                          width: 2,
                          color: AppColor.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Text(
                          widget.lst[index].companyName,
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
