import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterOption extends StatefulWidget {
  FilterOption({
    super.key,
    required this.lst,
    required this.nameOption,
    required this.onTap,
  });
  final List lst;
  final String nameOption;
  Function onTap;
  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                      widget.onTap(widget.lst[index]);
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0xFF01B763)
                            : Colors.white,
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF01B763),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Text(
                          widget.lst[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : const Color(0xFF01B763),
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
