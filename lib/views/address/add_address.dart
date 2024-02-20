import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/address/widgets/address_info_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/comfirm_widget.dart';
import 'package:flutter/material.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key, required this.onAddAddress});

  final Function(String name, String address) onAddAddress;

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController note = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode noteFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Thêm địa chỉ mới',
          style: TextStyle(
            color: AppColor.secondaryColor,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AddAddressWidget(
                title: 'Tên',
                content: 'Nhà',
                controller: name,
                focusNode: nameFocusNode,
              ),
              const SizedBox(height: 24),
              AddAddressWidget(
                title: 'Địa chỉ',
                content: 'Địa chỉ',
                controller: address,
                focusNode: addressFocusNode,
              ),
              const SizedBox(height: 24),
              AddAddressWidget(
                title: 'Ghi chú cho tài xế',
                content: 'Chỉ dẫn chi tiết địa điểm cho tài xế',
                controller: note,
                focusNode: noteFocusNode,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ComfirmWidget(
        content: 'Xác nhận',
        onTap: onConfirmPressed,
      ),
    );
  }

  void onConfirmPressed() {
    String name_ = name.text.trim();
    String address_ = address.text.trim();

    if (name_.isEmpty || address_.isEmpty) {
      String errorMessage = '';
      FocusNode focusNode;

      if (name_.isEmpty) {
        errorMessage = 'Vui lòng nhập tên gợi nhớ';
        focusNode = nameFocusNode;
      } else {
        errorMessage = 'Vui lòng nhập địa chỉ giao hàng';
        focusNode = addressFocusNode;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );

      FocusScope.of(context).requestFocus(focusNode);
    } else {
      widget.onAddAddress(name_, address_);
      Navigator.of(context).pop();
    }
  }
}
