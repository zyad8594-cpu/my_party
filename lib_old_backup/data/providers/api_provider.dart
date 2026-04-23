import 'package:get/get.dart';
import '../../core/services/api_service.dart';

class ApiProvider extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  // Auth
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiService.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await _apiService.post('/auth/register', data: data);
    return Map<String, dynamic>.from(response);
  }

  // Coordinators
  Future<List<dynamic>> getCoordinators() async {
    final response = await _apiService.get('/coordinators');
    return List<dynamic>.from(response);
  }

  Future<Map<String, dynamic>> getCoordinator(int id) async {
    final response = await _apiService.get('/coordinators/$id');
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> createCoordinator(
    Map<String, dynamic> data,
  ) async {
    final response = await _apiService.post('/coordinators', data: data);
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> updateCoordinator(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _apiService.put('/coordinators/$id', data: data);
    return Map<String, dynamic>.from(response);
  }

  Future<dynamic> deleteCoordinator(int id) async {
    return await _apiService.delete('/coordinators/$id');
  }

  // Suppliers
  Future<List<dynamic>> getSuppliers() async =>
      List<dynamic>.from(await _apiService.get('/suppliers'));
  Future<Map<String, dynamic>> getSupplier(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/suppliers/$id'));
  Future<Map<String, dynamic>> createSupplier(
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.post('/suppliers', data: data),
  );
  Future<Map<String, dynamic>> updateSupplier(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/suppliers/$id', data: data),
  );
  Future<void> deleteSupplier(int id) async =>
      await _apiService.delete('/suppliers/$id');

  // Services
  Future<List<dynamic>> getServices() async =>
      List<dynamic>.from(await _apiService.get('/services'));
  Future<Map<String, dynamic>> getService(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/services/$id'));
  Future<Map<String, dynamic>> createService(Map<String, dynamic> data) async =>
      Map<String, dynamic>.from(
        await _apiService.post('/services', data: data),
      );
  Future<Map<String, dynamic>> updateService(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/services/$id', data: data),
  );
  Future<void> deleteService(int id) async =>
      await _apiService.delete('/services/$id');

  // Clients
  Future<List<dynamic>> getClients() async =>
      List<dynamic>.from(await _apiService.get('/clients'));
  Future<Map<String, dynamic>> getClient(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/clients/$id'));
  Future<Map<String, dynamic>> createClient(Map<String, dynamic> data) async =>
      Map<String, dynamic>.from(await _apiService.post('/clients', data: data));
  Future<Map<String, dynamic>> updateClient(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/clients/$id', data: data),
  );
  Future<void> deleteClient(int id) async =>
      await _apiService.delete('/clients/$id');

  // Events
  Future<List<dynamic>> getEvents() async =>
      List<dynamic>.from(await _apiService.get('/events'));
  Future<Map<String, dynamic>> getEvent(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/events/$id'));
  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> data) async =>
      Map<String, dynamic>.from(await _apiService.post('/events', data: data));
  Future<Map<String, dynamic>> updateEvent(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/events/$id', data: data),
  );
  Future<void> deleteEvent(int id) async =>
      await _apiService.delete('/events/$id');

  // Tasks
  Future<List<dynamic>> getTasks() async =>
      List<dynamic>.from(await _apiService.get('/tasks'));
  Future<Map<String, dynamic>> getTask(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/tasks/$id'));
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> data) async =>
      Map<String, dynamic>.from(await _apiService.post('/tasks', data: data));
  Future<Map<String, dynamic>> updateTask(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/tasks/$id', data: data),
  );
  Future<void> deleteTask(int id) async =>
      await _apiService.delete('/tasks/$id');
  Future<Map<String, dynamic>> rateTask(
    int id,
    int value,
    String? comment,
  ) async => Map<String, dynamic>.from(
    await _apiService.post(
      '/tasks/$id/rate',
      data: {'value_rating': value, 'comment': comment},
    ),
  );

  // Incomes
  Future<List<dynamic>> getIncomes() async =>
      List<dynamic>.from(await _apiService.get('/incomes'));
  Future<Map<String, dynamic>> getIncome(int id) async =>
      Map<String, dynamic>.from(await _apiService.get('/incomes/$id'));
  Future<Map<String, dynamic>> createIncome(Map<String, dynamic> data) async =>
      Map<String, dynamic>.from(await _apiService.post('/incomes', data: data));
  Future<Map<String, dynamic>> updateIncome(
    int id,
    Map<String, dynamic> data,
  ) async => Map<String, dynamic>.from(
    await _apiService.put('/incomes/$id', data: data),
  );
  Future<void> deleteIncome(int id) async =>
      await _apiService.delete('/incomes/$id');

  // Notifications
  Future<List<dynamic>> getNotifications() async =>
      List<dynamic>.from(await _apiService.get('/notifications'));
  Future<void> deleteNotification(int id) async =>
      await _apiService.delete('/notifications/$id');
  Future<void> clearAllNotifications() async =>
      await _apiService.delete('/notifications');
}
