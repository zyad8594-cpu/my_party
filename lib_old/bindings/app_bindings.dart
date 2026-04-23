import 'package:get/get.dart';
// import '../presentation/controllers/auth_controller.dart';
// import '../presentation/controllers/home_controller.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../core/services/storage_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // الخدمات الأساسية
    Get.lazyPut<StorageService>(() => StorageService());
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthService>(() => AuthService());

    // // المتحكمات العامة
    // Get.lazyPut<AuthController>(() => AuthController());
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}
