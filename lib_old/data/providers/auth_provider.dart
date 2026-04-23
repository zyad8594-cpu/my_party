import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/services/api_service.dart';
import '../../core/services/auth_service.dart' show UserModel;
// import '../data/models/user_model.dart';

class AuthProvider {
  final ApiService _apiService = Get.find<ApiService>();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'token': data['data']['token'],
          'user': UserModel.fromJson(data['data']['coordinator']),
        };
      }
      throw Exception('Login failed');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.register,
        data: userData,
      );
      if (response.statusCode == 201) {
        return {'id': response.data['data']['id']};
      }
      throw Exception('Registration failed');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data['error'] ?? 'Unknown error';
    }
    return e.message ?? 'Connection error';
  }
}
