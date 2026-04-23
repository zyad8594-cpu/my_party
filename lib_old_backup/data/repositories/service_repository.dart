import 'package:get/get.dart';
import '../models/service.dart';
import '../providers/api_provider.dart';

class ServiceRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Service>> getAll() async {
    final data = await _apiProvider.getServices();
    return data.map((e) => Service.fromJson(e)).toList();
  }

  Future<Service> getById(int id) async {
    final data = await _apiProvider.getService(id);
    return Service.fromJson(data);
  }

  Future<Service> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createService(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Service.fromJson(response);
  }

  Future<Service> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateService(id, data);
    return Service.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteService(id);
  }
}