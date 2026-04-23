
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class CoordinatorService 
{
  static Future<List<models.CoordinatorModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('coordinators');
      
      if (response['success'] == true) 
      {
        final List<dynamic> usersJson = response['data'];
        return usersJson.map((json) => models.CoordinatorModel.fromJson(json)).toList();
      } 
      else 
      {
        throw {response['message'] ?? 'Failed to fetch users'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get users service error'};
    }
  }

  // جلب مستخدم بواسطة ID
  static Future<models.CoordinatorModel?> show(int id) async 
  {
    try 
    {
      final response = await ApiService.get('coordinators/$id');
      
      if (response['success'] == true) 
      {
        final jsonData = json.decode(response['data']);
        return models.CoordinatorModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to fetch user: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get user by id service error'};
    }
  }
  
  static Future<models.CoordinatorModel?> create(models.CoordinatorModel user) async 
  {
    try 
    {
      final response = await ApiService.post('coordinators', 
      {
        'name': user.full_name,
        'email': user.email,
        'password': user.password,
        'phone_number': user.phone_number,
      });
      
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
  
  // تحديث مستخدم
  static Future<models.CoordinatorModel?> update(models.CoordinatorModel user) async 
  {
    try 
    {
      final response = await ApiService.put('coordinators/${user.coordinator_id}', user.toJson());
      
      if (response['success'] == 200) 
      {
        final jsonData = json.decode(response['data']);
        return models.CoordinatorModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to update user: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Update user service error'};
    }
  }
  
  // حذف مستخدم
  static Future<bool> delete(int id) async 
  {
    try 
    {
      final response = await ApiService.delete('coordinators/$id');
      
      if (response['success'] == 200) 
      {
        return true;
      } 
      else 
      {
        throw {'Failed to delete user: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Delete user service error'};
    }
  }

}