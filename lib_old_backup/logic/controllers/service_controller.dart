import 'package:get/get.dart';
import 'package:my_party/data/repositories/service_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/service.dart';

class ServiceController extends GetxController {
  final ServiceRepository _repository = Get.find<ServiceRepository>();

  final services = <Service>[].obs;
  final selectedService = Rxn<Service>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  Future<void> fetchServices() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      services.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchService(int id) async {
    isLoading.value = true;
    try {
      final service = await _repository.getById(id);
      selectedService.value = service;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createService(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newService = await _repository.create(data);
      services.add(newService);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateService(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = services.indexWhere((c) => c.id == id);
      if (index != -1) services[index] = updated;
      selectedService.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteService(int id) async {
    try {
      await _repository.delete(id);
      services.removeWhere((c) => c.id == id);
      if (selectedService.value?.id == id) {
        selectedService.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}