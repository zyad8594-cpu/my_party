import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/coordinator_repository.dart';
import '../../logic/controllers/coordinator_controller.dart';

class CoordinatorBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => CoordinatorRepository());
    Get.lazyPut(() => CoordinatorController());
  }
}