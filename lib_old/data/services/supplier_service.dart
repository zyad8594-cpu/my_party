
part of 'services.dart';

// خدمة المستخدمين للتعامل مع API المستخدمين
class SupplierService 
{
  static Future<List<models.SupplierModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('suppliers');
      
      if (response['success'] == true) 
      {
        final List<dynamic> suppliersJson = response['data'];
        return suppliersJson.map((json) => models.SupplierModel.fromJson(json)).toList();
      } 
      else 
      {
        throw {response['message'] ?? 'Failed to fetch Suppliers'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Suppliers service error'};
    }
  }

  // جلب مستخدم بواسطة ID
  static Future<models.SupplierModel?> show(int id) async 
  {
    try 
    {
      final response = await ApiService.get('suppliers/$id');
      
      if (response['success'] == true) 
      {
        final jsonData = json.decode(response['data']);
        return models.SupplierModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to fetch Supplier: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Get Supplier by id service error'};
    }
  }
  
  static Future<models.SupplierModel?> create(models.SupplierModel supplier) async 
  {
    try 
    {
      final response = await ApiService.post('suppliers', 
      {
        
      });
      
      if (response['success'] == true) 
      {
        return models.SupplierModel.fromJson(response['data']);
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
  static Future<models.SupplierModel?> update(models.SupplierModel supplier) async 
  {
    try 
    {
      final response = await ApiService.put('suppliers/${supplier.supplier_id}', supplier.toJson());
      
      if (response['success'] == 200) 
      {
        final jsonData = json.decode(response['data']);
        return models.SupplierModel.fromJson(jsonData['data']);
      } 
      else 
      {
        throw {'Failed to update Supplier: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Update Supplier service error'};
    }
  }
  
  // حذف مستخدم
  static Future<bool> delete(int id) async 
  {
    try 
    {
      final response = await ApiService.delete('suppliers/$id');
      
      if (response['success'] == 200) 
      {
        return true;
      } 
      else 
      {
        throw {'Failed to delete Supplier: ${response["message"]}'};
      }
    } 
    catch (e) 
    {
      throw {...(e as Set<String>), 'Delete Supplier service error'};
    }
  }

}