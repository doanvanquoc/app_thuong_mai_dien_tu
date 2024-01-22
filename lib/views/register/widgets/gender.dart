import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/itemgender.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Gender extends StatefulWidget {
  Gender({super.key, required this.controller, required this.selectedGender});

  final TextEditingController controller;
  String selectedGender;

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  int stateButton = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 45, top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 2,
          color: Colors.grey[200]!,
        ),
        color: Colors.grey[200]!,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.controller.text.isNotEmpty
                  ? widget.controller.text
                  : widget.selectedGender,
              style: TextStyle(
                color: widget.controller.text.isNotEmpty
                    ? Colors.black
                    : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Chọn giới tính',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                      ItemGender(
                        onTap: (selectedGender) {
                          setState(() {
                            widget.selectedGender = selectedGender;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: MyButton(
                            onTap: () {
                              _updateGender();
                              Navigator.pop(context);
                            },
                            content: 'Xác nhận'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _updateGender() {
    if (widget.selectedGender.isNotEmpty) {
      setState(() {
        widget.controller.text = widget.selectedGender;
      });
    }
  }
}
