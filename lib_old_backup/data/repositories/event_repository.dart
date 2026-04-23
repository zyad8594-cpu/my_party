import 'package:get/get.dart';
import '../models/event.dart';
import '../providers/api_provider.dart';

class EventRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Event>> getAll() async {
    final data = await _apiProvider.getEvents();
    return data.map((e) => Event.fromJson(e)).toList();
  }

  Future<Event> getById(int id) async {
    final data = await _apiProvider.getEvent(id);
    return Event.fromJson(data);
  }

  Future<Event> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createEvent(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Event.fromJson(response);
  }

  Future<Event> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateEvent(id, data);
    return Event.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteEvent(id);
  }
}