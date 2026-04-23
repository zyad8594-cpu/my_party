import 'package:get/get.dart';
import '../providers/api_provider.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _apiProvider.login(email, password);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    return await _apiProvider.register(data);
  }
}