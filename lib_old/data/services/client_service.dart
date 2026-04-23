
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class ClientService 
{
  static Future<List<models.ClientModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('clients');
      
      if (response['success'] == true) 
      {
        final List<dynamic> clientsJson = response['data'];
        return clientsJson.map((json) => models.ClientModel.fromJson(json)).toList();
      } 
      else 
      {
        throw {response['message'] ?? 'Failed to fetch clients'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get clients service error'};
    }
  }

  // جلب مستخدم بواسطة ID
  static Future<models.ClientModel?> show(int id) async 
  {
    try 
    {
      final response = await ApiService.get('clients/$id');
      
      if (response['success'] == true) 
      {
        final jsonData = json.decode(response['data']);
        return models.ClientModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to fetch client: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get client by id service error'};
    }
  }
  
  static Future<models.ClientModel?> create(models.ClientModel client) async 
  {
    try 
    {
      final response = await ApiService.post('clients', 
      {
        'name': client.full_name,
        'email': client.email,
        'phone_number': client.phone_number,
      });
      
      if (response['success'] == true) 
      {
        return models.ClientModel.fromJson(response['data']);
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
  static Future<models.ClientModel?> update(models.ClientModel client) async 
  {
    try 
    {
      final response = await ApiService.put('clients/${client.client_id}', client.toJson());
      
      if (response['success'] == 200) 
      {
        final jsonData = json.decode(response['data']);
        return models.ClientModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to update client: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Update client service error'};
    }
  }
  
  // حذف مستخدم
  static Future<bool> delete(int id) async 
  {
    try 
    {
      final response = await ApiService.delete('clients/$id');
      
      if (response['success'] == 200) 
      {
        return true;
      } 
      else 
      {
        throw {'Failed to delete client: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Delete client service error'};
    }
  }

}