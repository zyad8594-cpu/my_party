import 'package:get/get.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/coordinator.dart';
import '../../data/repositories/coordinator_repository.dart';

class CoordinatorController extends GetxController {
  final CoordinatorRepository _repository = Get.find<CoordinatorRepository>();

  final coordinators = <Coordinator>[].obs;
  final selectedCoordinator = Rxn<Coordinator>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCoordinators();
    super.onInit();
  }

  Future<void> fetchCoordinators() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      coordinators.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCoordinator(int id) async {
    isLoading.value = true;
    try {
      final coordinator = await _repository.getById(id);
      selectedCoordinator.value = coordinator;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createCoordinator(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newCoordinator = await _repository.create(data);
      coordinators.add(newCoordinator);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCoordinator(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = coordinators.indexWhere((c) => c.id == id);
      if (index != -1) coordinators[index] = updated;
      selectedCoordinator.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCoordinator(int id) async {
    try {
      await _repository.delete(id);
      coordinators.removeWhere((c) => c.id == id);
      if (selectedCoordinator.value?.id == id) {
        selectedCoordinator.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}