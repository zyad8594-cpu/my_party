
import 'package:get/get.dart';
import '../../data/data.dart' as TaskAssignRpMd show TaskAssignRepository, TaskAssignModel;


class TaskAssign extends GetxController 
{
  final TaskAssignRpMd.TaskAssignRepository _taskAssigneeRepository = TaskAssignRpMd.TaskAssignRepository();

  var isLoading = false.obs;
  final errorMessage = ''.obs;
  final taskAssignees = <TaskAssignRpMd.TaskAssignModel?>[].obs;
  final userTasks = [].obs;

  // تعيين مهمة لمستخدم
  Future<bool> assignTask(int taskId, int userId) async 
  {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      await _taskAssigneeRepository.assignTask(taskId, userId);
      isLoading.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // إلغاء تعيين مهمة
  Future<bool> unassignTask(int taskId, int userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      await _taskAssigneeRepository.unassignTask(taskId, userId);
      isLoading.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // جلب معيني مهمة معينة
  Future<void> fetchTaskAssignees(int taskId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      taskAssignees.value.assignAll((await _taskAssigneeRepository.getTaskAssignees(taskId)) ?? []);
      isLoading.value = false;
      // notifyListeners();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value  = e.toString();
      // notifyListeners();
    }
  }

  // جلب مهام مستخدم معين
  Future<void> fetchUserTasks(int userId) async {
    isLoading.value  = true;
    errorMessage.value  = '';
    // notifyListeners();

    try {
      userTasks.value  = await _taskAssigneeRepository.getUserTasks(userId) ?? [];
      isLoading.value  = false;
      // notifyListeners();
    } catch (e) {
      isLoading.value  = false;
      errorMessage.value  = e.toString();
      // notifyListeners();
    }
  }

  // تعيين متعددة لمهمة
  Future<bool> assignMultipleTasks(int taskId, List<int> userIds) async {
    isLoading.value  = true;
    errorMessage.value  = '';
    // notifyListeners();

    try {
      await _taskAssigneeRepository.assignMultiple(taskId, userIds);
      isLoading.value  = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value  = false;
      errorMessage.value  = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // إلغاء تعيين جميع معيني مهمة
  Future<bool> unassignAllTaskAssignees(int taskId) async {
    isLoading.value  = true;
    errorMessage.value  = '';
    // notifyListeners();

    try {
      await _taskAssigneeRepository.unassignAll(taskId);
      isLoading.value  = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value  = false;
      errorMessage.value  = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // تنظيف الأخطاء
  void clearError() {
    errorMessage.value  = '';
    // notifyListeners();
  }

  // إعادة تعيين البيانات
  void reset() {
    taskAssignees.value  = [];
    userTasks.value  = [];
    errorMessage.value  = '';
    isLoading.value  = false;
    // notifyListeners();
  }
}