import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:dio/dio.dart';

class UserAPI {
  final Dio _dio = Dio();

  static final UserAPI instance = UserAPI._internal();
  UserAPI._internal();

  // Phương thức để lấy thông tin người dùng bằng ID
  Future<Map<String, dynamic>> getUserById(int userId) async {
    try {
      final response = await _dio.get('${APIConfig.API_URL}/user/$userId');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        log('Không thể lấy thông tin người dùng có id: $userId: ${response.statusCode}');
        return {'error': 'Lỗi server'};
      }
    } catch (e) {
      log('$e');
      return {'error': 'Lỗi kết nối'};
    }
  }

  // Phương thức để đăng nhập
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data;
        // ignore: dead_code
        log('Đăng nhập thành công');
      } else {
        log('Lỗi đăng nhập: ${response.statusCode}');
        return {'error': 'Sai email hoặc mật khẩu'};
      }
    } catch (e) {
      log('$e');
      return {'error': 'Lỗi kết nối'};
    }
  }

  // Phương thức để đăng ký
  Future<Map<String, dynamic>> registerUser(String email, String password, String fullname,String birthday, String phoneNumber) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/auth/register',
        data: {'email': email, 'password': password, 'fullname': fullname,'birthday':birthday,'phoneNumber':phoneNumber},
      );

      if (response.statusCode == 201) {
        return response.data;
        // ignore: dead_code
        log('Đăng ký thành công');
      } else {
        log('Lỗi đăng ký: ${response.statusCode}');
        return {'error': 'Lỗi server'};
      }
    } catch (e) {
      log('$e');
      return {'error': 'Lỗi kết nối'};
    }
  }
}
