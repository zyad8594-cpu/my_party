import 'package:get/get.dart';
import 'package:my_party/data/repositories/client_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/client.dart';

class ClientController extends GetxController {
  final ClientRepository _repository = Get.find<ClientRepository>();

  final clients = <Client>[].obs;
  final selectedClient = Rxn<Client>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchClients();
    super.onInit();
  }

  Future<void> fetchClients() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      clients.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchClient(int id) async {
    isLoading.value = true;
    try {
      final client = await _repository.getById(id);
      selectedClient.value = client;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createClient(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newClient = await _repository.create(data);
      clients.add(newClient);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateClient(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = clients.indexWhere((c) => c.id == id);
      if (index != -1) clients[index] = updated;
      selectedClient.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteClient(int id) async {
    try {
      await _repository.delete(id);
      clients.removeWhere((c) => c.id == id);
      if (selectedClient.value?.id == id) {
        selectedClient.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}