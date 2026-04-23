

part of 'services.dart';

// خدمة المهام للتعامل مع API المهام
class TaskService {
  
  // جلب جميع المهام
  static Future<List<models.TaskModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('tasks');
      if (response['success'] == true) 
      {
        final List<dynamic> tasksJson = response['data'];
        return tasksJson.map((json) => models.TaskModel.fromJson(json)).toList();
      } 
      else 
      {
        throw Exception('Failed to fetch tasks: ${response["message"]}');
      }
    } 
    catch (e) 
    {
      throw Exception('Get tasks service error: $e');
    }
  }
  
  // جلب مهام حدث معين
  static Future<List<models.TaskModel>?> getEventTasks(int eventId) async {
    try {
      final response = await ApiService.get('tasks/event/$eventId');
      
      if (response['success'] == true) 
      {
        final List<dynamic> tasksJson = response['data'];
        return tasksJson.map((json) => models.TaskModel.fromJson(json)).toList();
      } 
      else 
      {
        throw ['Failed to fetch event tasks: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), "Get event tasks service error"];
    }
  }

  static Future<List<dynamic>?> fetchTaskAssigns(int taskId) async {
    try {
      final response = await ApiService.get('tasks/$taskId');
      
      if (response['success'] == true) 
      {
        
        return response['data'];
      } 
      else 
      {
        throw ['Failed to fetch event tasks: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), "Get event tasks service error"];
    }
  }
  
  // إنشاء مهمة جديدة
  static Future<models.TaskModel?> create(models.TaskModel task) async {
    try {
      var data = {
        'event_id': task.event_id,
        'title': task.type_task,
        if(task.description != null)'description': task.description,
        'status': task.status,
      };
      final response = await ApiService.post('tasks', data);
      
      if (response['success'] == true) 
      {
        return models.TaskModel.fromJson(response['data']);
      } 
      else 
      {
        throw ['Failed to create task: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), 'Create task service error'];
    }
  }
  
  // تحديث مهمة
  static Future<models.TaskModel?> update(models.TaskModel task) async 
  {
    try {
      final response = await ApiService.put('tasks/${task.task_id}', task.toJson());
      
      if (response['success'] == true) 
      {
        return models.TaskModel.fromJson(response['data']);
      } 
      else 
      {
        throw ['Failed to update task: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), 'Update task service error'];
    }
  }
  
  // حذف مهمة
  static Future<bool> delete(int id) async {
    try {
      final response = await ApiService.delete('tasks/$id');
      
      if (response['success'] == true) 
      {
        return true;
      } 
      else 
      {
        throw ['Failed to delete task: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), 'Delete task service error'];
    }
  }
}