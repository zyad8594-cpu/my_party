import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/income_repository.dart';
import '../../logic/controllers/income_controller.dart';

class IncomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => IncomeRepository());
    Get.lazyPut(() => IncomeController());
  }
}