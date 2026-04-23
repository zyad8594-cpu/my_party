import 'package:get/get.dart';
import '../models/task.dart';
import '../providers/api_provider.dart';

class TaskRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Task>> getAll() async {
    final data = await _apiProvider.getTasks();
    return data.map((e) => Task.fromJson(e)).toList();
  }

  Future<Task> getById(int id) async {
    final data = await _apiProvider.getTask(id);
    return Task.fromJson(data);
  }

  Future<Task> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createTask(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Task.fromJson(response);
  }

  Future<Task> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateTask(id, data);
    return Task.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteTask(id);
  }
}