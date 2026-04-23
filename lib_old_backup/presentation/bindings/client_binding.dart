import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/client_repository.dart';
import '../../logic/controllers/client_controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => ClientRepository());
    Get.lazyPut(() => ClientController());
  }
}