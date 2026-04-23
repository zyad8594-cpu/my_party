import 'package:get/get.dart';
import 'package:my_party/data/repositories/task_repository.dart';
import '../../core/utils/helpers.dart';
import '../../data/models/task.dart';

class TaskController extends GetxController {
  final TaskRepository _repository = Get.find<TaskRepository>();

  final tasks = <Task>[].obs;
  final selectedTask = Rxn<Task>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      final list = await _repository.getAll();
      tasks.value = list;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTask(int id) async {
    isLoading.value = true;
    try {
      final task = await _repository.getById(id);
      selectedTask.value = task;
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTask(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final newTask = await _repository.create(data);
      tasks.add(newTask);
      Get.back();
      showSnackbar('نجاح', 'تم إضافة المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(int id, Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final updated = await _repository.update(id, data);
      final index = tasks.indexWhere((c) => c.id == id);
      if (index != -1) tasks[index] = updated;
      selectedTask.value = updated;
      Get.back();
      showSnackbar('نجاح', 'تم تحديث المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _repository.delete(id);
      tasks.removeWhere((c) => c.id == id);
      if (selectedTask.value?.id == id) {
        selectedTask.value = null;
      }
      showSnackbar('نجاح', 'تم حذف المنسق');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    }
  }
}