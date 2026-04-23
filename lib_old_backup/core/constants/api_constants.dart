class ApiConstants {
  static const String baseUrl = 'http://localhost:3000/api'; // غيّر حسب عنوان خادمك

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String coordinators = '/coordinators';
  static const String suppliers = '/suppliers';
  static const String services = '/services';
  static const String clients = '/clients';
  static const String events = '/events';
  static const String tasks = '/tasks';
  static const String incomes = '/incomes';
  static const String notifications = '/notifications';

  // SharedPreferences keys
  static const String tokenKey = 'token';
  static const String userKey = 'user';
}