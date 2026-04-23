import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/data.dart' as TaskRpMd show TaskRepository, TaskModel, EventModel;

// Controller لإدارة المهام
class Task extends GetxController {
  final TaskRpMd.TaskRepository _taskRepository = Get.find();
  
  var isLoading = false.obs;                                    // حالة تحميل المهام
  var tasks = <TaskRpMd.TaskModel>[].obs;                               // قائمة المهام
  var selectedTask = Rxn<TaskRpMd.TaskModel>();                         // المهمة المحددة
  var eventTasks = <TaskRpMd.TaskModel>[].obs;                          // مهام حدث معين
  var filteredTasks = <TaskRpMd.TaskModel>[].obs;
  var currentFilter = 'all'.obs;
  var startDate = Rx<DateTime?>(null);
  var selectedEvent = Rx<TaskRpMd.EventModel?>(null);
  var taskAss = [].obs;
  // جلب جميع المهام
  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      
      final tasksList = await _taskRepository.getTasks();
      
      if (tasksList != null) {
        tasks.assignAll(tasksList);
      }
      
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch tasks: $e');
    }
  }

  // اختيار تاريخ البدء
  Future<void> selectStartDate(BuildContext context) async 
  {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    
    if (picked != null && picked != startDate.value) 
    {
      // استخدام GetBuilder لإعادة بناء الواجهة بدلاً من setState
      startDate.value = picked;
    }
  }
  
  // جلب مهام حدث معين
  Future<void> fetchEventTasks(int eventId) async {
    try {
      isLoading.value = true;
      
      final tasksList = await _taskRepository.getEventTasks(eventId);
      
      if (tasksList != null) {
        eventTasks.assignAll(tasksList);
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء', [...(e as List<String>), 'Failed to fetch event tasks'].join('\n'));
    }
  }

  Future<void> fetchTaskAssigns(int taskId) async 
  {
    try 
    {
      isLoading.value = true;
      
      final tasksass = await _taskRepository.fetchTaskAssigns(taskId);
      
      if (tasksass != null) {
        taskAss.assignAll(tasksass);
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء', [...(e as List<String>), 'Failed to fetch event tasks'].join('\n'));
    }
  }
  
  // task-assignees
  // إنشاء مهمة جديدة
  Future<bool> createTask(TaskRpMd.TaskModel task) async {
    try {
      isLoading.value = true;
      
      final newTask = await _taskRepository.createTask(task);
      
      if (newTask != null) {
        tasks.add(newTask);
        // إذا كانت المهمة تابعة لحدث، نضيفها لقائمة مهام الحدث
        if (task.eventId > 0) {
          eventTasks.add(newTask);
        }
        isLoading.value = false;
        Get.snackbar('Success', 'Task created successfully');
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to create task: $e');
      return false;
    }
  }

  // تحديث مهمة
  Future<bool> updateTask(TaskRpMd.TaskModel task) async {
    try {
      isLoading.value = true;
      
      final updatedTask = await _taskRepository.updateTask(task);
      
      if (updatedTask != null) {
        // تحديث المهمة في القائمة العامة
        final index = tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) 
        {
          tasks[index] = updatedTask;
        }
        
        // تحديث المهمة في قائمة مهام الحدث
        final eventIndex = eventTasks.indexWhere((t) => t.id == task.id);
        if (eventIndex != -1) {
          eventTasks[eventIndex] = updatedTask;
        }
        
        isLoading.value = false;
        Get.snackbar('نجاح', 'تم التعديل بنجاح');
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء',  [...(e as List<String>), 'Failed to update task'].join('\n'));
      return false;
    }
  }

  // حذف مهمة
  Future<bool> deleteTask(int id) async {
    try {
      isLoading.value = true;
      
      final success = await _taskRepository.deleteTask(id);
      
      if (success) {
        tasks.removeWhere((task) => task.id == id);
        eventTasks.removeWhere((task) => task.id == id);
        isLoading.value = false;
        Get.snackbar('Success', 'Task deleted successfully');
        return true;
      }
      
      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to delete task: $e');
      return false;
    }
  }

  // تغيير حالة المهمة
  Future<void> changeTaskStatus(int taskId, String newStatus) async {
    try 
    {
      final task = tasks.firstWhere((t) => t.id == taskId);
      final updatedTask = task.copyWith(status: newStatus);
      await updateTask(updatedTask);
    } 
    catch (e) {
      Get.snackbar('Error', 'Failed to change task status: $e');
    }
  }




  void updateCurrentFilter(String value) => currentFilter.value = value;
  
  // الحصول على المهام المصفاة
  List<TaskRpMd.TaskModel> getFilteredTasks( ) 
  {
    // isLoading.value = true;
    
    switch (currentFilter.value) {
      case 'pending':
        return tasks.where((task) => task.status == 'pending').toList();
      case 'in_progress':
        return tasks.where((task) => task.status == 'in_progress').toList();
      case 'completed':
        return tasks.where((task) => task.status == 'completed').toList();
      default:
        return tasks.toList();
    }
    // isLoading.value = false;
  }
}