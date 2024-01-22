// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/presenters/cart_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/save_local.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/widgets/cart_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/widgets/total_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key, required this.user});
  final User user;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Cart> cartProducts = [];
  List<Product> totalPro = [];

  @override
  void initState() {
    super.initState();
    loadCartProducts(forceUpdate: true);
  }

  Future<void> loadCartProducts({bool forceUpdate = false}) async {
    int userID = 1;
    List<Cart> loadedCartProducts = [];

    try {
      if (forceUpdate) {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          loadedCartProducts =
              await CartPresenter.instance.getCartDetails(userID);
          final cartData =
              jsonEncode(loadedCartProducts.map((e) => e.toJson()).toList());
          await SharedPreferencesPresenter.setCartData(cartData);
        } else {
          final cartDataString = await SharedPreferencesPresenter.getCartData();
          if (cartDataString != null && cartDataString.isNotEmpty) {
            loadedCartProducts = decodeCartData(cartDataString);
          }
        }
      } else {
        final cartDataString = await SharedPreferencesPresenter.getCartData();
        if (cartDataString != null && cartDataString.isNotEmpty) {
          loadedCartProducts = decodeCartData(cartDataString);
        }
      }

      if (mounted) {
        setState(() {
          cartProducts = loadedCartProducts;
        });
      }
    } catch (e) {
      log('Error calling API: $e');
      if (!forceUpdate) {
        final cartDataString = await SharedPreferencesPresenter.getCartData();
        if (cartDataString != null && cartDataString.isNotEmpty) {
          loadedCartProducts = decodeCartData(cartDataString);
          if (mounted) {
            setState(() {
              cartProducts = loadedCartProducts;
            });
          }
        }
      }
    }
  }

  List<Cart> decodeCartData(String cartDataString) {
    Iterable l = json.decode(cartDataString);
    return List<Cart>.from(l.map((model) => Cart.fromJson(model)));
  }

  // Future<List<Cart>> loadCartProducts() async {
  //   try {
  //     int userID = 1;
  //     cartProducts = await CartPresenter.instance.getCartDetails(userID);
  //     setState(() {
  //       cartProducts = cartProducts;
  //     });
  //     return cartProducts;
  //   } catch (e) {
  //     log('Lỗi khi lấy thông tin giỏ hàng: $e');
  //     return [];
  //   }
  // }

  // Future<List<Cart>> loadCartProducts({bool forceUpdate = false}) async {
  //   int userID = 1;
  //   List<Cart> serverCartProducts = [];
  //   final cartDataString = await SharedPreferencesPresenter.getCartData();

  //   var connectivityResult = await (Connectivity().checkConnectivity());

  //   if (connectivityResult != ConnectivityResult.none) {
  //     if (forceUpdate) {
  //       try {
  //         serverCartProducts =
  //             await CartPresenter.instance.getCartDetails(userID);
  //         final cartData =
  //             jsonEncode(serverCartProducts.map((e) => e.toJson()).toList());
  //         await SharedPreferencesPresenter.setCartData(cartData);
  //       } catch (e) {
  //         log('Lỗi không xác định khi gọi API: $e');
  //         // Xử lý khi gọi API không thành công
  //         if (cartDataString != null && cartDataString.isNotEmpty) {
  //           Iterable l = json.decode(cartDataString);
  //           return List<Cart>.from(l.map((model) => Cart.fromJson(model)));
  //         }
  //       }
  //     } else {
  //       // Khi không yêu cầu cập nhật từ server
  //       if (cartDataString != null && cartDataString.isNotEmpty) {
  //         Iterable l = json.decode(cartDataString);
  //         return List<Cart>.from(l.map((model) => Cart.fromJson(model)));
  //       }
  //     }
  //   } else {
  //     // Khi không có kết nối mạng
  //     if (cartDataString != null && cartDataString.isNotEmpty) {
  //       Iterable l = json.decode(cartDataString);
  //       return List<Cart>.from(l.map((model) => Cart.fromJson(model)));
  //     }
  //   }

  //   return [];
  // }

  void saveCartData() async {
    List<Map<String, dynamic>> modifiedCartData = [];
    for (var cartItem in cartProducts) {
      var userID = cartItem.userID ?? 1;
      var modifiedCartItem = {
        'cartID': cartItem.cartID,
        'userID': userID,
        'product': cartItem.product.toJson(),
        'quantity': cartItem.quantity,
      };
      modifiedCartData.add(modifiedCartItem);
    }
    final cartData = jsonEncode(modifiedCartData);
    await SharedPreferencesPresenter.setCartData(cartData);
  }

  void updateProductQuantity(int cartIndex, int newQuantity) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      Cart currentCart = cartProducts[cartIndex];
      if (newQuantity < 1) {
        return;
      }

      if (newQuantity > currentCart.product.quantity) {
        if (mounted) {
          setState(() {
            --newQuantity;
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Số lượng không đủ, chỉ còn ${currentCart.product.quantity} sản phẩm'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        );
        return;
      }

      bool result = await CartPresenter.instance
          .updateCartQuantity(currentCart.cartID, newQuantity);

      if (result) {
        if (mounted) {
          setState(() {
            currentCart.quantity = newQuantity;
          });
        }
        log('Cập nhật số lượng thành công');
      } else {
        log('Cập nhật số lượng thất bại');
        return;
      }
    } else {
      if (mounted) {
        setState(() {
          --newQuantity;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lỗi kết nối'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
    }
  }

  void removeProductFromCart(int index) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      int productID = cartProducts[index].product.productID;
      log(productID.toString());
      bool result =
          await CartPresenter.instance.removeProductFromCart(productID);
      if (result) {
        setState(() {
          cartProducts.removeAt(index);
        });
        log('Xóa thành công');
      } else {
        log('Xóa lỗi');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi kết nối'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        );
        return;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lỗi kết nối'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
    }
  }

  String calculateTotalPrice() {
    int total = 0;
    for (Cart cartItem in cartProducts) {
      total += cartItem.quantity * cartItem.product.price.toInt();
    }
    return Product.formatPrice(total.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: AppColor.secondaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 35,
              ))
        ],
      ),
      body: cartProducts.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                await loadCartProducts(forceUpdate: true);
              },
              child: Stack(children: [
                ListView.builder(
                  itemCount: cartProducts.length,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 85),
                  itemBuilder: (BuildContext context, int index) {
                    Cart cartProduct = cartProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: CartWidget(
                        image: cartProduct.product.images[0].imagePath,
                        name: cartProduct.product.productName,
                        price: Product.formatPrice(
                            cartProduct.product.price.toString()),
                        qty: cartProduct.quantity,
                        onQuantityChanged: (newQuantity) {
                          updateProductQuantity(index, newQuantity);
                        },
                        onDelete: () => removeProductFromCart(index),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TotalWidget(
                    user: widget.user,
                    products: cartProducts,
                    totalPrice: Product.formatPrice(
                        Product.parsePrice(calculateTotalPrice()).toString()),
                  ),
                )
              ]),
            )
          : Center(
              child: Column(
                children: [
                  const SizedBox(height: 110),
                  Image.asset('assets/images/empty.png'),
                  const SizedBox(height: 40),
                  const Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 2.2,
                    ),
                  ),
                  const Text(
                    'Bạn chưa thêm gì cả!',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
