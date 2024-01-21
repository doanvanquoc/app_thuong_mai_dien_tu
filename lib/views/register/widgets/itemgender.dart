import 'package:flutter/material.dart';

class ItemGender extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ItemGender({
    Key? key,
    required this.onTap,
  });

  final Function(String) onTap;

  @override
  // ignore: library_private_types_in_public_api
  _ItemGenderState createState() => _ItemGenderState();
}

class _ItemGenderState extends State<ItemGender> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onTap('Nam'); // Thêm callback ở đây
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? const Color(0xFF01B763)
                          : Colors.white,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFF01B763),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Text(
                        'Nam',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedIndex == 0
                              ? Colors.white
                              : const Color(0xFF01B763),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onTap('Nữ'); // Thêm callback ở đây
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? const Color(0xFF01B763)
                          : Colors.white,
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFF01B763),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Text(
                        'Nữ',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedIndex == 1
                              ? Colors.white
                              : const Color(0xFF01B763),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
