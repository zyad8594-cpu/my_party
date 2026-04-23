import 'package:get/get.dart';
import '../models/notification.dart';
import '../providers/api_provider.dart';

class NotificationRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<NotificationModel>> getAll() async {
    final data = await _apiProvider.getNotifications();
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteNotification(id);
  }

  Future<void> clearAll() async {
    await _apiProvider.clearAllNotifications();
  }
}
