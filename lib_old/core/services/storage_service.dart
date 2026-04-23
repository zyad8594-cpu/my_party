import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'auth_service.dart' show UserModel;
// import '../../data/models/user_model.dart';

class StorageService extends GetxService {
  late FlutterSecureStorage storage;

  Future<StorageService> init() async {
    storage = const FlutterSecureStorage();
    return this;
  }

  Future<void> setToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  Future<void> setUser(UserModel user) async {
    await storage.write(key: 'user', value: jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final userStr = await storage.read(key: 'user');
    if (userStr != null) {
      return UserModel.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
