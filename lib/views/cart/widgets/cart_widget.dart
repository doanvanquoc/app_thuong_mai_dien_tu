import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  CartWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.qty,
    required this.onQuantityChanged,
    this.isDel = true,
  });

  final String image;
  final String name;
  final String price;
  int qty;
  final Function(int) onQuantityChanged;
  final bool isDel;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  void updateQuantity(int newQuantity) {
    setState(() {
      widget.qty = newQuantity;
    });
    widget.onQuantityChanged(newQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C04060F),
            blurRadius: 60,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.name,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.price,
                    style: const TextStyle(
                      color: Color(0xFF01B763),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 0.07,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF8F8F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 16,
                                onPressed: widget.isDel
                                    ? () {
                                        if (widget.qty > 0) {
                                          updateQuantity(--widget.qty);
                                          if (widget.qty == 0) {
                                            showDeleteConfirmation(context);
                                          }
                                        }
                                      }
                                    : null,
                                icon: Transform.translate(
                                  offset: const Offset(0, -4.5),
                                  child: const Icon(
                                    Icons.minimize,
                                    color: Color(0xff109C5B),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.qty.toString(),
                              style: const TextStyle(
                                color: Color(0xFF01B763),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                iconSize: 16,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: widget.isDel
                                    ? () {
                                        updateQuantity(++widget.qty);
                                      }
                                    : null,
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xff109C5B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.isDel)
                        IconButton(
                          onPressed: () => showDeleteConfirmation(context),
                          icon: const Icon(Icons.delete),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 425,
          padding: const EdgeInsets.only(
            top: 8,
            left: 24,
            right: 24,
            bottom: 48,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFFF5F5F5),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 15),
              const Text(
                'Xóa khỏi giỏ hàng?',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(thickness: 0.5),
              const SizedBox(height: 17),
              CartWidget(
                image: widget.image,
                name: widget.name,
                price: widget.price,
                qty: widget.qty,
                onQuantityChanged: widget.onQuantityChanged,
                isDel: false,
              ),
              const SizedBox(height: 17),
              const Divider(thickness: 0.5),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      onTap: () {
                        if (widget.qty == 0) {
                          updateQuantity(++widget.qty);
                        }
                        Navigator.pop(context);
                      },
                      content: 'Hủy',
                      backgroundColor: const Color(0xffE6F8EF),
                      textColor: const Color(0xff01B763),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(child: MyButton(onTap: () {}, content: 'Xóa')),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
