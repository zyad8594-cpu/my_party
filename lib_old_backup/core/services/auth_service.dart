import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:get/get.dart';
import 'package:my_party/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final RxString token = ''.obs;
  final RxMap<String, dynamic> user = RxMap({});

  Future<AuthService> init() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString(ApiConstants.tokenKey) ?? '';
    if (token.isNotEmpty) {
      final userJson = prefs.getString(ApiConstants.userKey);
      if (userJson != null) {
        user.value = Map<String, dynamic>.from(jsonDecode(userJson));
      }
    }
    return this;
  }

  Future<void> saveAuthData(String newToken, Map<String, dynamic> userData) async {
    token.value = newToken;
    user.value = userData;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.tokenKey, newToken);
    await prefs.setString(ApiConstants.userKey, jsonEncode(userData));
  }

  Future<void> logout() async {
    token.value = '';
    user.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ApiConstants.tokenKey);
    await prefs.remove(ApiConstants.userKey);
    Get.offAllNamed(AppRoutes.login);
  }

  bool get isLoggedIn => token.isNotEmpty;
}