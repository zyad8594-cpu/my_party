import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/task_repository.dart';
import '../../logic/controllers/task_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => TaskRepository());
    Get.lazyPut(() => TaskController());
  }
}