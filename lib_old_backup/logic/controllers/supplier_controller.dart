import 'package:get/get.dart';
import 'package:my_party/data/repositories/supplier_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/supplier.dart';

class SupplierController extends GetxController {
  final SupplierRepository _repository = Get.find<SupplierRepository>();

  final suppliers = <Supplier>[].obs;
  final selectedSupplier = Rxn<Supplier>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchSuppliers();
    super.onInit();
  }

  Future<void> fetchSuppliers() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      suppliers.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSupplier(int id) async {
    isLoading.value = true;
    try {
      final supplier = await _repository.getById(id);
      selectedSupplier.value = supplier;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createSupplier(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newSupplier = await _repository.create(data);
      suppliers.add(newSupplier);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSupplier(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = suppliers.indexWhere((c) => c.id == id);
      if (index != -1) suppliers[index] = updated;
      selectedSupplier.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSupplier(int id) async {
    try {
      await _repository.delete(id);
      suppliers.removeWhere((c) => c.id == id);
      if (selectedSupplier.value?.id == id) {
        selectedSupplier.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}