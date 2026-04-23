import 'package:get/get.dart';                                  // استيراد مكتبة GetX
import '../../data/data.dart';
import '../../core/core.dart' as Constants show storage, Messages;
import '../../data/data.dart' as AuthU show  CoordinatorModel;             // مستودع المستخدمين
import '../../routes/routes.dart' as routes;
import 'basec_controller.dart' show BasecController;
import 'toolse.dart' show Toolse;                        // نموذج المستخدم

part 'auth_controller_login.dart';
part 'auth_controller_register.dart';
part 'auth_controller_update_profile.dart';


// Controller للمصادقة وإدارة حالة تسجيل الدخول
class Auth extends BasecController 
{
  static final name = ''.obs;
  static final email = ''.obs; 
  static final password = ''.obs;
  static final newPass = ''.obs;
  static final confirmPass = ''.obs;
  static final _isLoggedIn = false.obs; 
  static final _isLoading = false.obs; 

  static final Rx<AuthU.CoordinatorModel?> currentUser = Rx(null);
  static AuthU.CoordinatorModel? get user => currentUser.value;
   
  static bool isLoading([bool? isLoading])=> Toolse.set(_isLoading, isLoading);
  static bool isLoggedIn([bool? isLoggedIn]) =>  Toolse.set(_isLoggedIn, isLoggedIn);
  // final AuthU.AuthService _authService = Get.find();
  // final GetStorage _storage = GetStorage();
  
  static void resetAll()
  {
    Auth.name.value = '';
    Auth.email.value = ''; 
    Auth.password.value = '';
    Auth.newPass.value = '';
    Auth.confirmPass.value = '';
    Auth._isLoading.value = false;
  }
  // التحقق مما إذا كان المستخدم مسجل الدخول مسبقاً
  static AuthU.CoordinatorModel? auth() 
  {
    if(user == null)
    {
      final token = Constants.storage.read('token');                       // قراءة token من التخزين
      final userData = Constants.storage.read('user');  
      if (token != null && userData != null) 
      {
        // إذا وجد token وبيانات مستخدم، نعيد بناء UserModel
        currentUser.value = AuthU.CoordinatorModel.fromJson(userData);
      }
    }
    
    
    return user;
  }

  
  // تسجيل الخروج
  static void logout() 
  {
    Constants.storage.remove('token');                                   // حذف token
    Constants.storage.remove('user');                                    // حذف بيانات المستخدم
    currentUser.value = null;                                   // مسح المستخدم الحالي
    Auth.isLoggedIn(false);
    Auth.resetAll();
    Get.offAllNamed(routes.Names.AUTH_LOGIN);                                  // الانتقال لصفحة Login
  }
  

}