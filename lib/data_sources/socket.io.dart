import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/presenters/order_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/socket_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket _socket;
  late BuildContext _context;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void init(BuildContext context) {
    _context = context;

    // Khởi tạo kết nối Socket.IO
    _socket = IO.io('https://api.vanquoc.id.vn', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connecting', (data) {
      log('connectiing');
    });

    // Lắng nghe sự kiện từ server và cập nhật trạng thái thông qua Provider
    _socket.on('order_updated', (data) async {
      log('Nhận được tín hiệu vũ trụ từ server');
      SharedPreferences.getInstance().then(
        (instance) {
          final token = instance.getString('fcmToken');
          log('Dòng 40 order view: $token');
          _socket.emit('updated_order_ui', token);
        },
      );
      final orders = await OrderPresenter.instance.getUserOrders();
      final orderStatus1 =
          orders.where((element) => element.status.statusID == 1).toList();
      final orderStatus2 =
          orders.where((element) => element.status.statusID == 2).toList();
      final orderStatus3 =
          orders.where((element) => element.status.statusID == 3).toList();

      // ignore: use_build_context_synchronously
      Provider.of<SocketPresenter>(_context, listen: false)
          .onListenEvent(orders, orderStatus1, orderStatus2, orderStatus3);
    });
  }

  // Hàm để gửi dữ liệu đến server (nếu cần)
  void emitEvent(String eventName, dynamic data) {
    _socket.emit(eventName, data);
  }

  // Hàm để đóng kết nối
  void disconnect() {
    _socket.disconnect();
  }
}
