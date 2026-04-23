import 'package:get/get.dart';
import '../models/income.dart';
import '../providers/api_provider.dart';

class IncomeRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Income>> getAll() async {
    final data = await _apiProvider.getIncomes();
    return data.map((e) => Income.fromJson(e)).toList();
  }

  Future<Income> getById(int id) async {
    final data = await _apiProvider.getIncome(id);
    return Income.fromJson(data);
  }

  Future<Income> create(Map<String, dynamic> data) async {
    final response = await _apiProvider.createIncome(data);
    // response قد تحتوي على id فقط، فنعيد السجل كاملاً بعد إنشائه
    return Income.fromJson(response);
  }

  Future<Income> update(int id, Map<String, dynamic> data) async {
    final response = await _apiProvider.updateIncome(id, data);
    return Income.fromJson(response);
  }

  Future<void> delete(int id) async {
    await _apiProvider.deleteIncome(id);
  }
}