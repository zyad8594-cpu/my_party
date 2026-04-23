part of 'auth_controller.dart';

extension Register on Auth
{
  static Future<void> register() async 
  {
    if(Auth.isLoading() == false)
    {
      try 
      {
        // التحقق من صحة المدخلات
        if (
          !Toolse.emailIsValid(Auth.email.value) || 
          !Toolse.passwordIsValid(Auth.password.value) ||
          (Toolse.passwordIsValid(Auth.password.value) && Auth.password.value != Auth.confirmPass.value)
        ) 
        {
          return;
        }

        Auth.isLoading(true);
        // إنشاء نموذج المستخدم
        final user = AuthU.CoordinatorModel(
          coordinator_id: 0, // سيتم تعيينه من الخادم
          full_name: Auth.name.value.trim(),
          email: Auth.email.value.trim(),
          password: Auth.password.value.trim(),
          created_at: DateTime.now(),
        );

        
        final newUser = await AuthService.register(user);     // استدعاء API للتسجيل
        
        if (newUser != null) 
        {
          Get.snackbar(Constants.Messages.title.success, Constants.Messages.login.success);     // رسالة نجاح
          Auth.isLoading(false);
          Get.offAllNamed(routes.Names.AUTH_LOGIN); // العودة لصفحة تسجيل الدخول
          return;
        }
        
        Auth.isLoading(false);return;
      } 
      catch (e) 
      {
        Get.snackbar(Constants.Messages.title.error, [...(e as List<String>), Constants.Messages.register.error].join('\n'));
        Auth.isLoading(false);
      }
    }
  }
  
}