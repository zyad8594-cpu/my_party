import 'package:get/get.dart';
import 'storage_service.dart';
// import '../../data/models/user_model.dart';

class AuthService extends GetxService {
  final storage = Get.find<StorageService>();
  final _isLoggedIn = false.obs;
  final _currentUser = Rxn<UserModel>();

  bool get isLoggedIn => _isLoggedIn.value;
  UserModel? get currentUser => _currentUser.value;

  Future<void> saveUserAndToken(String token, UserModel user) async {
    await storage.setToken(token);
    await storage.setUser(user);
    _currentUser.value = user;
    _isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await storage.clearAll();
    _currentUser.value = null;
    _isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  Future<void> checkLoginStatus() async {
    final token = await storage.getToken();
    final user = await storage.getUser();
    if (token != null && user != null) {
      _currentUser.value = user;
      _isLoggedIn.value = true;
    }
  }
}

class UserModel {
  Object? toJson() {
    return null;
  }

  static Future<UserModel?> fromJson(jsonDecode) async {
    return null;
  }
}
