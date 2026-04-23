
import 'dart:convert';                                        // لتحويل JSON
import 'package:http/http.dart' as http;
import '../../core/core.dart' as Constants show 
      Config, storage, Messages;                      // للطلبات HTTP
import '../models/models.dart' as models;

part 'auth_service.dart';
part 'client_service.dart';
part 'coordinator_service.dart';
part 'event_service.dart';
part 'income_service.dart';
part 'notifications_servicel.dart';
part 'rating_task_service.dart';
part 'service_service.dart';
part 'supplier_service.dart';
part 'task_service.dart';

// خدمة API الأساسية للتواصل مع الخادم
class ApiService 
{
  // static final GetStorage _storage = Constants.storage;                   // instance للتخزين المحلي
  // URL الأساسي للAPI
  // ⚠️ استبدل هذا الرابط برابط الخادم الحقيقي
  static final String baseUrl = Constants.Config.apiArl;
  
  // دالة لإنشاء headers للطلبات
  static Future<Map<String, String>> _getHeaders() async
  {
    final token = await Constants.storage.read('token') as String?;                     // قراءة token من التخزين
    return 
    {
      'Accept': '*/*',
      'Content-Type': 'application/json',                    // نوع المحتوى JSON
      if(token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',   // إضافة token إذا موجود
    };
  }

  // معالجة الاستجابة والتحقق من الأخطاء
  static Map<String, dynamic> _handleResponse(http.Response response) 
  {
    
    var data = json.decode(response.body);
    // data['statuscode'] = response.statusCode;
    // data['success'] = response.statusCode >= 200 && response.statusCode < 300;
    return data;
    // if (response.statusCode >= 200 && response.statusCode < 300) 
    // {
    //   return json.decode(response.body);
    // }
      
    // throw {Constants.Messages.requestWithStatus(response.statusCode).error};
  }
  
  // GET request
  static Future<Map<String, dynamic>> get(String endpoint) async 
  {
    try 
    {
      return ApiService._handleResponse(await http.get
      (
        Uri.parse('${ApiService.baseUrl}/$endpoint'),
        headers: await ApiService._getHeaders(),
      ));
    } 
    catch (e) 
    {
      rethrow;
      // throw (e is Iterable) ? {...e, Constants.Messages.requestOf('GET').error} : {Constants.Messages.requestOf('GET').error};
    }
  }
  
  // POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async 
  {
    try 
    {
      return ApiService._handleResponse(await http.post
      (
        Uri.parse('${ApiService.baseUrl}/$endpoint'),
        headers: await ApiService._getHeaders(),
        body: json.encode(data),
      ));
    } 
    catch (e) 
    {
      rethrow;
      // throw (e is Set) ? {...e, Constants.Messages.requestOf('POST').error} : {Constants.Messages.requestOf('POST').error};
      
    }
  }

  // PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async 
  {
    try 
    {
       return ApiService._handleResponse(await http.put
      (
        Uri.parse('${ApiService.baseUrl}/$endpoint'),
        headers: await ApiService._getHeaders(),
        body: json.encode(data),
      ));
    } 
    catch (e) 
    {
      rethrow;
      // throw (e is Set) ? {...e, Constants.Messages.requestOf('PUT').error} : {Constants.Messages.requestOf('PUT').error};
    }
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async 
  {
    try 
    {
      return ApiService._handleResponse(await http.delete
      (
        Uri.parse('${ApiService.baseUrl}/$endpoint'),
        headers: await ApiService._getHeaders(),
      ));
    } 
    catch (e) 
    {
      rethrow;
      // throw (e is Set) ? {...e, Constants.Messages.requestOf('DELETE').error} : {Constants.Messages.requestOf('DELETE').error};
    }
  }

  // Upload file
  static Future<Map<String, dynamic>> uploadFile(String endpoint, String filePath) async 
  {
    try 
    {
      var request = http.MultipartRequest('POST', Uri.parse('${ApiService.baseUrl}/$endpoint'));
      
      // إضافة headers
      request.headers.addAll(await ApiService._getHeaders());
      
      // إضافة الملف
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      
      // إرسال الطلب
      var response = await request.send();
      // var responseData = await response.stream.bytesToString();
      
      if (response.statusCode >= 200 && response.statusCode < 300)
      {
        return json.decode(await response.stream.bytesToString());
      }
      
      throw {Constants.Messages.uploadWithStatus(response.statusCode).error};
    } 
    catch (e) 
    {
      rethrow;
      // throw (e is Set) ? {...e, Constants.Messages.fileUpload.error} : {Constants.Messages.fileUpload.error};
    }
  }
}