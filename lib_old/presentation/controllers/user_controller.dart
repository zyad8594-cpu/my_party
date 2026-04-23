import 'package:get/get.dart';
import '../../core/core.dart' as Constents show Messages;
import '../../data/data.dart' as UserRpMd show UserRepository, UserModel;

// Controller لإدارة المستخدمين
class User extends GetxController 
{
  final UserRpMd.UserRepository _userRepository = Get.find();
  
  var isLoading = false.obs;                                    // حالة تحميل المستخدمين
  var users = <UserRpMd.UserModel>[].obs;                               // قائمة المستخدمين
  var selectedUser = Rxn<UserRpMd.UserModel>();                         // المستخدم المحدد

  // جلب جميع المستخدمين
  Future<List<UserRpMd.UserModel>> all() async 
  {
    try 
    {
      isLoading.value = true;
      
      final usersList = await _userRepository.getUsers();
      
      if (usersList != null) 
      {
        users.assignAll(usersList);
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar(Constents.Messages.title.error, 'Failed to fetch users: $e');
    }
    return users.value;
  }
  

  Future<void> getUsersTask() async 
  {
    try 
    {
      isLoading.value = true;
      
      final usersList = await _userRepository.getUsers();
      
      if (usersList != null) 
      {
        users.assignAll(usersList);
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar(Constents.Messages.title.error, 'Failed to fetch users: $e');
    }
  }
  
  // task-assignees
  // جلب مستخدم بواسطة ID
  Future<void> fetchUserById(int id) async 
  {
    try 
    {
      isLoading.value = true;
      
      final user = await _userRepository.getUserById(id);
      
      if (user != null) 
      {
        selectedUser.value = user;
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar(Constents.Messages.title.error, 'Failed to fetch user: $e');
    }
  }

  // تحديث مستخدم
  Future<bool> updateUser(UserRpMd.UserModel user) async 
  {
    try 
    {
      isLoading.value = true;
      
      final updatedUser = await _userRepository.updateUser(user);
      
      if (updatedUser != null) 
      {
        // تحديث المستخدم في القائمة
        final index = users.indexWhere((u) => u.id == user.id);
        if (index != -1) 
        {
          users[index] = updatedUser;
        }
        isLoading.value = false;
        Get.snackbar(Constents.Messages.title.success, 'User updated successfully');
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar(Constents.Messages.title.error, 'Failed to update user: $e');
      return false;
    }
  }

  // حذف مستخدم
  Future<bool> deleteUser(int id) async 
  {
    try 
    {
      isLoading.value = true;
      
      final success = await _userRepository.deleteUser(id);
      
      if (success) 
      {
        users.removeWhere((user) => user.id == id);
        isLoading.value = false;
        Get.snackbar(Constents.Messages.title.success, 'User deleted successfully');
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar(Constents.Messages.title.error, 'Failed to delete user: $e');
      return false;
    }
  }
}