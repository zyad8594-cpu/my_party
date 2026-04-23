import 'package:get/get.dart';
import '../models/client.dart';
import '../providers/api_provider.dart';

class ClientRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Client>> getAll() async {
    final data = await _apiProvider.getClients();
    return data.map((e) => Client.fromJson(e)).toList();
  }

  Future<Client> getById(int id) async {
    final data = await _apiProvider.getClient(id);
    return Client.fromJson(data);
  }

  Future<Client> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createClient(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Client.fromJson(response);
  }

  Future<Client> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateClient(id, data);
    return Client.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteClient(id);
  }
}