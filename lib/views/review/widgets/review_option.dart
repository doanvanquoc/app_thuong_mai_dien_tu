import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewOption extends StatefulWidget {
  ReviewOption({
    super.key,
    required this.lst,
    required this.onTap,
    this.check,
  });
  final List lst;
  Function onTap;
  bool? check;
  @override
  State<ReviewOption> createState() => _ReviewOptionState();
}

class _ReviewOptionState extends State<ReviewOption> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.check!) {
      selectedIndex = -1;
      widget.check = false;
    }
    return SizedBox(
      height: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          widget.onTap('-1');
                        } else {
                          selectedIndex = index;
                          widget.onTap(widget.lst[index]);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColor.primaryColor
                            : Colors.white,
                        border:
                            Border.all(width: 2, color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : AppColor.primaryColor,
                            ),
                            Text(
                              widget.lst[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : AppColor.primaryColor,
                              ),
                            ),
                          ],
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
