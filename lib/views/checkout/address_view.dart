import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:app_thuong_mai_dien_tu/presenters/address_presenter.dart';
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
  Future<List<Address>> loadAddresses() async {
    return await AddressPresenter.instance.getUserAddresses(1);
  }

  List<Address> addresses = [];

  Address? selectedAddress;
  int? selectedAddressIndex;

  @override
  void initState() {
    super.initState();
    loadAddresses().then((loadedAddresses) {
      if(mounted){
        setState(() {
        addresses = loadedAddresses;
        if (addresses.isNotEmpty) {
          addresses[0].isDefault = true;
          for (int i = 1; i < addresses.length; i++) {
            addresses[i].isDefault = false;
          }
        }
        updateSelectedAddressIndex();
      });
      }
    });
  }

  void updateSelectedAddressIndex() {
    if (widget.selectedAddress != null) {
      selectedAddressIndex = addresses.indexWhere(
          (address) => address.addressID == widget.selectedAddress!.addressID);
    }

    if (selectedAddressIndex == -1 || selectedAddressIndex == null) {
      if (addresses.isNotEmpty) {
        selectedAddressIndex = 0;
      } else {
        selectedAddressIndex = null;
      }
    }
  }

  void addNewAddress(String street) async {
    bool isSuccess = await AddressPresenter.instance.addNewAddress(1, street);

    if (isSuccess) {
      loadAddresses().then((loadedAddresses) {
        if(mounted){
          setState(() {
          addresses = loadedAddresses;
          selectedAddressIndex = addresses.length - 1;
        });
        }
      });
    } else {
      log('Thêm thất bại');
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
                  addressID: address.addressID,
                  address: address.address,
                  isIcon: false,
                  isRadioButton: true,
                  isSelected: selectedAddressIndex != null &&
                      index == selectedAddressIndex,
                  onSelected: () {
                    if(mounted){
                      setState(() {
                      selectedAddressIndex = index;
                    });
                    }
                  },
                  isDefault: address.isDefault,
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
                .then((value) => {
                      if (mounted) {setState(() {})}
                    });
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
}
