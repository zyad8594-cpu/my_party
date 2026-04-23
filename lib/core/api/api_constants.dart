import '../config/config.dart' show Config;

class ApiConstants 
{
  static const urls = [
    'http://192.168.1.5:3000/api',
    'http://localhost:3000/api',
    'http://192.168.1.3:3000/api',
    'http://192.168.43.39:3000/api'
  ];

  static final String baseUrl = urls[2]; // عنوان الـ IP المحلي للوصول من أجهزة أخرى
  
  static const String userAgent = '${Config.APP_NAME}/${Config.APP_VERSION}';
  
}

// Endpoints
class ApiEndpoints
{
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String users = '/users';
  static const String userChangePassword = '/users/change-password';
  static const String usersByRole = '/users/role';
  static const String coordinators = '/coordinators';
  static const String suppliers = '/suppliers';
  static const String services = '/services';
  static const String serviceRequests = '/services/requests';
  static const String clients = '/clients';
  static const String events = '/events';
  static const String tasks = '/tasks';
  static const String incomes = '/incomes';
  static const String notifications = '/users/notifications';
  static const String notificationsReadAll = '/users/notifications-read-all';
  static const String notificationsClear = '/users/notifications-clear';
  static const String dashboard = '/dashboard';
  static const String systemUsers = '/system_users';

  static const String suppliersWithCoordinatorRating = '/suppliers/rated-by-coordinator';
}

// SharedPreferences keys
class ApiKeys
{
  static const String tokenKey = 'token';
  static const String userKey = 'user';
}