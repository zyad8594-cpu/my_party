
part of 'constants.dart';
// تكوين التطبيق والإعدادات البيئية
class Config 
{
  static const String APP_NAME = 'نظام إدارة الحفلات'; // اسم التطبيق
  
  static final apiArl = API_URLs.first; // current api Url
  
  static const String JWT_SECRET = 'your-jwt-secret-key-here';

  static const int JWT_EXPIRY = 24; // ساعة
 
  static final database = DATABASES.first;

  static const API_URLs = [
    'http://localhost/projects/my_party/api', // Laravel
    'http://localhost:3000/api', // Node.js
    'http://localhost:8080/api', // Spring Boot
    
    'http://zyad-host-manage.liveblog365.com/api',
    'https://zyad.infinityfreeapp.com/api',
  ]; 
  
  static const DATABASES = [
    DataBase(
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: '',
      name: 'my_party',
    ),
    DataBase(
      host: 'sql107.ezyro.com',
      port: 3306,
      username: 'ezyro_40237004',
      password: '66f447003d',
      name: 'ezyro_40237004_my_party',
    ),
    DataBase(
      host: 'sql113.infinityfree.com',
      port: 3306,
      username: 'if0_39827029', 
      password: 'zyad734170461',
      name: 'if0_39827029_my_party',
    ),
  ];
  
  
}

final class DataBase
{
  final String type;
  final String host;
  final String name;
  final int port;
  final String username;
  final String password;
  final String charset;

  const DataBase({
    this.type = 'mysql',
    required this.host,
    required this.name,
    required this.port,
    required this.username,
    required this.password,
    this.charset = 'utf8mb4'
  });
}