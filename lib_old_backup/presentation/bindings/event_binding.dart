import 'package:get/get.dart';
// import '../../data/providers/api_provider.dart';
import '../../data/repositories/event_repository.dart';
import '../../logic/controllers/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => EventRepository());
    Get.lazyPut(() => EventController());
  }
}