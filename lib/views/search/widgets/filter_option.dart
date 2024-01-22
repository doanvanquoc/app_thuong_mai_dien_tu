import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterOption extends StatefulWidget {
  FilterOption({
    super.key,
    required this.lst,
    required this.nameOption,
    required this.checkOptioin,
    required this.check,
  });
  final List<Company> lst;
  final String nameOption;
  Function checkOptioin;
  bool check;

  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
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
                      if(mounted){
                        setState(() {
                        if (selectedIndex == index) {
                          selectedIndex = -1;
                          widget.checkOptioin('');
                        } else {
                          selectedIndex = index;
                          widget.checkOptioin(widget.lst[index].companyName);
                        }
                      });
                      }
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
