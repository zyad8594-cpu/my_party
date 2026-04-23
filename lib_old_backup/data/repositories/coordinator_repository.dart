import 'package:get/get.dart';
import '../models/coordinator.dart';
import '../providers/api_provider.dart';

class CoordinatorRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Coordinator>> getAll() async {
    final data = await _apiProvider.getCoordinators();
    return data.map((e) => Coordinator.fromJson(e)).toList();
  }

  Future<Coordinator> getById(int id) async {
    final data = await _apiProvider.getCoordinator(id);
    return Coordinator.fromJson(data);
  }

  Future<Coordinator> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createCoordinator(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Coordinator.fromJson(response);
  }

  Future<Coordinator> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateCoordinator(id, data);
    return Coordinator.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteCoordinator(id);
  }
}