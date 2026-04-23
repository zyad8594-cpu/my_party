import 'package:get/get.dart';
import 'package:my_party/data/repositories/event_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/event.dart';

class EventController extends GetxController {
  final EventRepository _repository = Get.find<EventRepository>();

  final events = <Event>[].obs;
  final selectedEvent = Rxn<Event>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      events.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEvent(int id) async {
    isLoading.value = true;
    try {
      final event = await _repository.getById(id);
      selectedEvent.value = event;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEvent(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newEvent = await _repository.create(data);
      events.add(newEvent);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEvent(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = events.indexWhere((c) => c.id == id);
      if (index != -1) events[index] = updated;
      selectedEvent.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEvent(int id) async {
    try {
      await _repository.delete(id);
      events.removeWhere((c) => c.id == id);
      if (selectedEvent.value?.id == id) {
        selectedEvent.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}