
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class AuthService 
{

  // تسجيل الدخول
  static Future<dynamic> login(String email, String password) async 
  {
    try 
    {
      final response = await ApiService.post('auth/login', 
      {
        'email': email,
        'password': password,
      });
      
      if (response['success'] == true) 
      {
        // حفظ token إذا وجد
        if (response['token'] != null) 
        {
          Constants.storage.write('token', response['token']);
          
        }
        return response['data'];
      } 
      else 
      {
        throw {response['message'] ?? Constants.Messages.login.error};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), Constants.Messages.login_service.error};
    }
  }
  
  static Future<models.CoordinatorModel?> register(models.CoordinatorModel user) async 
  {
    try 
    {
      final response = await ApiService.post('auth/register', 
        user.toJsonE(true, coordinator_id: false, created_at: false, updated_at: false)
      );
      
      if (response['success'] == true) 
      {
        return models.CoordinatorModel.fromJson(response['data']);
      } 
      else 
      {
        throw {response['message'] ?? Constants.Messages.register.error};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), Constants.Messages.login.error};
    }
  }

  static Future<models.CoordinatorModel?> updateProfile(models.CoordinatorModel coordinator) async
  {
    return CoordinatorService.update(coordinator);
  }
}