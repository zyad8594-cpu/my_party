
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class IncomeService 
{
  static Future<List<models.IncomeModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('incomes');
      
      if (response['success'] == true) 
      {
        final List<dynamic> incomesJson = response['data'];
        return incomesJson.map((json) => models.IncomeModel.fromJson(json)).toList();
      } 
      else 
      {
        throw {response['message'] ?? 'Failed to fetch Incomes'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Incomes service error'};
    }
  }

  // جلب مستخدم بواسطة ID
  static Future<models.IncomeModel?> show(int id) async 
  {
    try 
    {
      final response = await ApiService.get('incomes/$id');
      
      if (response['success'] == true) 
      {
        final jsonData = json.decode(response['data']);
        return models.IncomeModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to fetch Income: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Income by id service error'};
    }
  }
  
  static Future<models.IncomeModel?> create(models.IncomeModel income) async 
  {
    try 
    {
      final response = await ApiService.post('incomes', 
      {
        
      });
      
      if (response['success'] == true) 
      {
        return models.IncomeModel.fromJson(response['data']);
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
  static Future<models.IncomeModel?> update(models.IncomeModel income) async 
  {
    try 
    {
      final response = await ApiService.put('incomes/${income.income_id}', income.toJson());
      
      if (response['success'] == 200) 
      {
        final jsonData = json.decode(response['data']);
        return models.IncomeModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to update Income: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Update Income service error'};
    }
  }
  
  // حذف مستخدم
  static Future<bool> delete(int id) async 
  {
    try 
    {
      final response = await ApiService.delete('incomes/$id');
      
      if (response['success'] == 200) 
      {
        return true;
      } 
      else 
      {
        throw {'Failed to delete Income: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Delete Income service error'};
    }
  }

}