import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/supplier_repository.dart';
import '../../logic/controllers/supplier_controller.dart';

class SupplierBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => SupplierRepository());
    Get.lazyPut(() => SupplierController());
  }
}