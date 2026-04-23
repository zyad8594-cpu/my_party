import 'package:get/get.dart';
import '../../../features/notifications/data/repository/notification_repository.dart';
import '../../../features/notifications/controller/notification_controller.dart';
import '../../../features/notifications/provider/notification_provider.dart';

class NotificationBinding extends Bindings 
{
  @override
  void dependencies() 
  {
    if(!Get.isRegistered<NotificationRepository>()){
      Get.put(NotificationRepository(), permanent: true);
    }
    if(!Get.isRegistered<NotificationController>()){
      Get.put(NotificationController(), permanent: true);
    }
    if(!Get.isRegistered<NotificationProvider>()){
      Get.put(NotificationProvider(), permanent: true);
    }
  }
}
