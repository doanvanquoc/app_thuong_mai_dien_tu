import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:dio/dio.dart';

class UserAPI {
  final Dio _dio = Dio();
  static final UserAPI instance = UserAPI._internal();
  UserAPI._internal();

  // Lấy thông tin user theo userId
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

  // Phương thức đăng nhập bằng email và pass trả về token và mess
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

  //Phương thức đăng ký trả về code, mess và token
  Future<Map<String, dynamic>> registerUser(
    String email,
    String password,
    String fullname,
    DateTime birthday,
    String phoneNumber,
    String sex,
    String avatar,
  ) async {
    try {
      final formattedBirthday =
          birthday.toLocal().toIso8601String().split('T')[0];
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

      if (response.data != null && response.data is Map<String, dynamic>) {
        if (response.data.containsKey('message') &&
            response.data['message'] == 'OK') {
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

  //Phương thức check email đã tông tại trong csdl chưa?
  Future<Map<String, dynamic>> checkEmail(String email) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/auth/check',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData.containsKey('code')) {
          if (responseData['code'] == 1) {
            log('Email chưa tồn tại');
            return responseData;
          } else {
            log('Email đã tồn tại');
            return responseData;
          }
        } else {
          return {'error': 'Lỗi không xác định từ server'};
        }
      } else {
        log('Lỗi kiểm tra email: ${response.statusCode}');
        return {'error': 'Lỗi kiểm tra email'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }

  // Phương thức kiểm tra tính hợp lệ của token
  Future<Map<String, dynamic>> verifyToken(String token) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/auth/verify',
        data: {'token': token},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData.containsKey('code')) {
          if (responseData['code'] == 1) {
            // Token hợp lệ, trả về dữ liệu người dùng
            log('Token hợp lệ');
            return responseData;
          } else {
            log('Token không hợp lệ');
            return responseData;
          }
        } else {
          return {'error': 'Lỗi không xác định từ server'};
        }
      } else {
        log('Lỗi kiểm tra token: ${response.statusCode}');
        return {'error': 'Lỗi kiểm tra token'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }

  // Phương thức đổi mật khẩu
  Future<Map<String, dynamic>> changePass(
      int userId, String oldPass, String newPass) async {
    try {
      final response = await _dio.post(
        '${APIConfig.API_URL}/user/change-pass',
        data: {'userID': userId, 'oldPass': oldPass, 'newPass': newPass},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData.containsKey('code')) {
          if (responseData['code'] == 1) {
            // Token hợp lệ, trả về dữ liệu người dùng
            log('Đổi mật khẩu thành công!');
            return responseData;
          } else {
            log('Mật khẩu cũ không chính xác!');
            return responseData;
          }
        } else {
          return {'error': 'Lỗi không xác định từ server'};
        }
      } else {
        log('Lỗi kiểm tra mật khẩu: ${response.statusCode}');
        return {'error': 'Lỗi kiểm tra mật khẩu'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }

//Phương thức cập nhật thông tin user thông qua userid
  Future<Map<String, dynamic>> updateUser({
    required int userId,
    required String email,
    required String fullname,
    required DateTime birthday,
    required String phoneNumber,
    required String sex,
  }) async {
    try {
      final formattedBirthday =birthday.toLocal().toIso8601String().split('T')[0];
      final response = await _dio.post(
        '${APIConfig.API_URL}/user/update',
        data: {
          'userID': userId,
          'email': email,
          'fullname': fullname,
          'birthday': formattedBirthday,
          'phone_number': phoneNumber,
          'sex': sex,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData != null && responseData.containsKey('code')) {
          if (responseData['code'] == 1) {
            log('Cập nhật thông tin thành công!');
            log(responseData.toString());
            return responseData;
          } else {
            log('Lỗi khi cập nhật thông tin: ${responseData['message']}');
            return responseData;
          }
        } else {
          return {'error': 'Lỗi không xác định từ server'};
        }
      } else {
        log('Lỗi cập nhật thông tin: ${response.statusCode}');
        return {'error': 'Lỗi cập nhật thông tin'};
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return {'error': 'Lỗi kết nối'};
    }
  }
}
