import 'package:get/get.dart';
import 'package:my_party/data/repositories/income_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/income.dart';

class IncomeController extends GetxController {
  final IncomeRepository _repository = Get.find<IncomeRepository>();

  final incomes = <Income>[].obs;
  final selectedIncome = Rxn<Income>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchIncomes();
    super.onInit();
  }

  Future<void> fetchIncomes() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      incomes.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchIncome(int id) async {
    isLoading.value = true;
    try {
      final income = await _repository.getById(id);
      selectedIncome.value = income;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createIncome(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newIncome = await _repository.create(data);
      incomes.add(newIncome);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateIncome(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = incomes.indexWhere((c) => c.id == id);
      if (index != -1) incomes[index] = updated;
      selectedIncome.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteIncome(int id) async {
    try {
      await _repository.delete(id);
      incomes.removeWhere((c) => c.id == id);
      if (selectedIncome.value?.id == id) {
        selectedIncome.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}