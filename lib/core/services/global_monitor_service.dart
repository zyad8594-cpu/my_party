import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/utils.dart' show MyPUtils;
import '../api/auth_service.dart';
import '../routes/app_routes.dart';

class GlobalMonitorService extends GetxService {
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Timer? _authTimer;

  Future<GlobalMonitorService> init() async {
    // 1. Monitor network connection
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        if (!Get.isSnackbarOpen && Get.currentRoute != AppRoutes.networkError) {
          MyPUtils.showSnackbar(
            'تنبيه',
            'انقطع الاتصال بالإنترنت',
            position: SnackPosition.TOP,
          );
          Get.toNamed(AppRoutes.networkError);
        }
      }
    });

    // 2. Monitor authentication session periodically
    _authTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      final authService = Get.find<AuthService>();
      // Get.snackbar('title', 'message');
      
      if (!authService.isLoggedIn) {
        if (AppRoutes.requireAuth(Get.currentRoute)) {
          AuthService.logout();
        }
      }
    });

    return this;
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    _authTimer?.cancel();
    super.onClose();
  }
}
