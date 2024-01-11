import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RateOption extends StatefulWidget {
  RateOption({
    super.key,
    required this.lst,
    required this.onTap,
  });
  final List lst;
  Function onTap;
  @override
  State<RateOption> createState() => _RateOptionState();
}

class _RateOptionState extends State<RateOption> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                      widget.onTap(widget.lst[index]);
                      setState(() {
                        selectedIndex = index;
                        print(index);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0xFF01B763)
                            : Colors.white,
                        border: Border.all(
                            width: 2, color: const Color(0xFF01B763)),
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
                                  : const Color(0xFF01B763),
                            ),
                            Text(
                              widget.lst[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : const Color(0xFF01B763),
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
