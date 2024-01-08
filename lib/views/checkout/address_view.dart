import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/address_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/comfirm_widget.dart';
import 'package:flutter/material.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key, this.selectedAddress});

  final Address? selectedAddress;

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  List<Address> addresses = [
    Address(
      name: 'Nhà',
      street: '65 Huỳnh Thúc Kháng, Quận 1',
      isDefault: true,
    ),
    Address(
      name: 'Công ty',
      street: '652/37 Cộng Hòa, P13, Tân Bình',
      isDefault: false,
    ),
    Address(
      name: 'Trọ',
      street: '231/93/5 Dương Bá Trạc, P1, Quận 8',
      isDefault: false,
    ),
    Address(
      name: 'Công ty',
      street: '652/37 Cộng Hòa, P13, Tân Bình',
      isDefault: false,
    ),
  ];

  Address? selectedAddress;
  int? selectedAddressIndex;

  @override
  void initState() {
    super.initState();
    if (widget.selectedAddress != null) {
      selectedAddressIndex = addresses.indexWhere((address) =>
          address.name == widget.selectedAddress!.name &&
          address.street == widget.selectedAddress!.street);
    }

    if (selectedAddressIndex == -1 || selectedAddressIndex == null) {
      selectedAddressIndex =
          addresses.indexWhere((address) => address.isDefault!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa chỉ giao hàng',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(addresses.length, (index) {
              Address address = addresses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AddressItem(
                  name: address.name,
                  street: address.street,
                  isIcon: false,
                  isRadioButton: true,
                  isSelected: selectedAddressIndex != null &&
                      index == selectedAddressIndex,
                  onSelected: () {
                    setState(() {
                      selectedAddressIndex = index;
                    });
                  },
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: ComfirmWidget(
        content: 'Xác nhận',
        onTap: () {
          if (selectedAddressIndex != null) {
            Navigator.pop(context, addresses[selectedAddressIndex!]);
          }
        },
      ),
    );
  }
}
