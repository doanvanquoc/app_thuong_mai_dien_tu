import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/address/add_address.dart';
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
      addressID: 'Nhà',
      address: '65 Huỳnh Thúc Kháng, Quận 1',
      isDefault: true,
    ),
    Address(
      addressID: 'Công ty',
      address: '652/37 Cộng Hòa, P13, Tân Bình',
      isDefault: false,
    ),
    Address(
      addressID: 'Trọ',
      address: '231/93/5 Dương Bá Trạc, P1, Quận 8',
      isDefault: false,
    ),
    Address(
      addressID: 'Một Buổi Sáng',
      address: '27/4 Cộng Hòa, P4, Tân Bình',
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
          address.addressID == widget.selectedAddress!.addressID &&
          address.address == widget.selectedAddress!.address);
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
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Địa chỉ giao hàng',
          style: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(addresses.length, (index) {
              Address address = addresses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AddressItem(
                  name: address.addressID,
                  isDefault: address.isDefault!,
                  street: address.address,
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
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: MyButton(
          content: '+',
          backgroundColor: const Color(0xffE6F8EF),
          textColor: const Color(0xff01B763),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddAddressView(onAddAddress: addNewAddress)))
                .then((value) => {setState(() {})});
          },
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

  void addNewAddress(String name, String street) {
    setState(() {
      addresses
          .add(Address(addressID: name, address: street, isDefault: false));
      selectedAddressIndex = addresses.length - 1;
    });
  }
}
