import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:dio/dio.dart';

class UserAPI {
  final Dio _dio = Dio();
  static final UserAPI instance = UserAPI._internal();
  UserAPI._internal();

  Future<Map<String, dynamic>> getUserById(int userId) async {
    try {
      final response = await _dio.get('${APIConfig.API_URL}/user/$userId');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        log('Không thể lấy thông tin người dùng có id: $userId - ${response.statusCode}');
        return {'error': 'Lỗi server'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData.containsKey('token')) {
          log('Đăng nhập thành công');
          return responseData;
        } else {
          return {'error': 'Tài khoản hoặc mật khẩu không đúng!'};
        }
      } else if (response.statusCode == 400) {
        log('Vui lòng nhập đầy đủ thông tin!');
        return {'error': 'Vui lòng nhập đầy đủ thông tin!'};
      } else {
        log('Lỗi đăng nhập: ${response.statusCode}');
        return {'error': 'Tài khoản hoặc mật khẩu không đúng!'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }

 Future<Map<String, dynamic>> registerUser(
  String email, String password, String fullname,
  DateTime birthday, String phoneNumber, String sex, String avatar
) async {
  try {
    final formattedBirthday = birthday.toLocal().toIso8601String().split('T')[0];
    final response = await _dio.post(
      '${APIConfig.API_URL}/auth/register',
      data: {
        'email': email,
        'password': password,
        'fullname': fullname,
        'birthday': formattedBirthday,
        'phone_number': phoneNumber,
        'avatar': avatar,
        'sex': sex,
      },
    );

    log(response.data.toString());

    if (response.data != null && response.data is Map<String, dynamic>) {
      // Kiểm tra xem thuộc tính 'message' có tồn tại không
      if (response.data.containsKey('message') && response.data['message'] == 'OK') {
        log('Đăng ký thành công! ${response.data}');
        return response.data;
      } else {
        return {'error': 'Email đã tồn tại!'};
      }
    } else {
      return {'error': 'Lỗi không xác định từ server'};
    }
  } catch (e) {
    log('Lỗi kết nối: $e');
    return {'error': 'Lỗi kết nối'};
  }
}
}
