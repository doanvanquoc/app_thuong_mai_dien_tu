import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  AddressItem({
    super.key,
    required this.name,
    required this.street,
    required this.isIcon,
    required this.isRadioButton,
    this.isSelected = true,
    this.onSelected,
  });

  final String name;
  final String street;
  final bool isIcon;
  final bool isRadioButton;
  bool isSelected;
  late VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 380,
          height: 92,
          padding: const EdgeInsets.all(20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0C04060F),
                blurRadius: 60,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: const Color(0x1401B763),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Container(
                  width: 33,
                  height: 33,
                  padding: const EdgeInsets.fromLTRB(6, 7, 5, 8),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-0.96, 0.28),
                      end: Alignment(0.96, -0.28),
                      colors: [Color(0xFF01B763), Color(0xFF14E584)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Color(0xffe5fce8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        street,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                child: isRadioButton
                    ? Radio<bool>(
                        value: isSelected,
                        groupValue: true,
                        onChanged: (bool? value) {
                          if (onSelected != null) {
                            onSelected!();
                          }
                        },
                        activeColor: const Color(0xff01bb5c),
                      )
                    : IconButton(
                        onPressed: onSelected,
                        icon: const Icon(
                          Icons.mode_edit_rounded,
                          color: Color(0xff01bb5c),
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
