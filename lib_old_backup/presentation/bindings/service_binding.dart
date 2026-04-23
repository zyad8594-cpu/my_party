import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => ServiceRepository());
    Get.lazyPut(() => ServiceController());
  }
}