import 'package:get/get.dart';
import 'package:my_party/data/repositories/notification_repository.dart';
import 'package:my_party/logic/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepository>(() => NotificationRepository());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
