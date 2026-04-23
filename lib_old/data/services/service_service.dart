
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class ServiceService 
{
  static Future<List<models.ServiceModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('services');
      
      if (response['success'] == true) 
      {
        final List<dynamic> servicesJson = response['data'];
        return servicesJson.map((json) => models.ServiceModel.fromJson(json)).toList();
      } 
      else 
      {
        throw {response['message'] ?? 'Failed to fetch Services'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Services service error'};
    }
  }

  // جلب مستخدم بواسطة ID
  static Future<models.ServiceModel?> show(int id) async 
  {
    try 
    {
      final response = await ApiService.get('services/$id');
      
      if (response['success'] == true) 
      {
        final jsonData = json.decode(response['data']);
        return models.ServiceModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to fetch Service: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Service by id service error'};
    }
  }
  
  static Future<models.ServiceModel?> create(models.ServiceModel service) async 
  {
    try 
    {
      final response = await ApiService.post('services', 
      {
        
      });
      
      if (response['success'] == true) 
      {
        return models.ServiceModel.fromJson(response['data']);
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
  static Future<models.ServiceModel?> update(models.ServiceModel service) async 
  {
    try 
    {
      final response = await ApiService.put('services/${service.service_id}', service.toJson());
      
      if (response['success'] == 200) 
      {
        final jsonData = json.decode(response['data']);
        return models.ServiceModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to update Service: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Update Service service error'};
    }
  }
  
  // حذف مستخدم
  static Future<bool> delete(int id) async 
  {
    try 
    {
      final response = await ApiService.delete('services/$id');
      
      if (response['success'] == 200) 
      {
        return true;
      } 
      else 
      {
        throw {'Failed to delete Service: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Delete Service service error'};
    }
  }

}