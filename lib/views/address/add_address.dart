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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thêm địa chỉ mới',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AddAddressWidget(title: 'Tên', content: 'Nhà', controller: name),
            const SizedBox(height: 24),
            AddAddressWidget(
                title: 'Địa chỉ', content: 'Địa chỉ', controller: address),
            const SizedBox(height: 24),
            AddAddressWidget(
                title: 'Ghi chú cho tài xế',
                content: 'Chỉ dẫn chi tiết địa điểm cho tài xế',
                controller: note),
          ],
        ),
      ),
      bottomNavigationBar: ComfirmWidget(
        content: 'Xác nhận',
        onTap: onConfirmPressed,
      ),
    );
  }

  void onConfirmPressed() {
    String name_ = name.text;
    String address_ = address.text;
    widget.onAddAddress(name_, address_);
    Navigator.of(context).pop();
  }
}
