import 'package:get/get.dart';
import '../models/supplier.dart';
import '../providers/api_provider.dart';

class SupplierRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Supplier>> getAll() async {
    final data = await _apiProvider.getSuppliers();
    return data.map((e) => Supplier.fromJson(e)).toList();
  }

  Future<Supplier> getById(int id) async {
    final data = await _apiProvider.getSupplier(id);
    return Supplier.fromJson(data);
  }

  Future<Supplier> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createSupplier(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Supplier.fromJson(response);
  }

  Future<Supplier> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateSupplier(id, data);
    return Supplier.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteSupplier(id);
  }
}