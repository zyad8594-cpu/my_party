import 'package:get/get.dart';
import 'package:my_party/data/repositories/notification_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/notification.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = Get.find<NotificationRepository>();

  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      notifications.value = list;
    } catch (e) {
      // Don't show snackbar for empty notifications or 404 for now
      // as backend might not be fully ready.
      notifications.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNotification(int id) async {
    try {
      await _repository.delete(id);
      notifications.removeWhere((n) => n.id == id);
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }

  Future<void> clearAll() async {
    try {
      await _repository.clearAll();
      notifications.clear();
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}
