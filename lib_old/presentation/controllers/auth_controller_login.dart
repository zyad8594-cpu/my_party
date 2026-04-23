part of 'auth_controller.dart';


extension Login on Auth
{
  // تسجيل الدخول
  static Future<void> login() async 
  {
    if(Auth.isLoading() == false)
    {
      try 
      {
        // التحقق من صحة المدخلات
        
        if (!Toolse.emailIsValid(Auth.email.value) || !Toolse.passwordIsValid(Auth.password.value)) 
        {
          return;
        }
        Auth.isLoading(true);                                   // بدء التحميل
        

        final data = await AuthService.login(Auth.email.value, Auth.password.value); // استدعاء API لتسجيل الدخول
        final user = data['coordinator'];
        if (user != null) 
        {  
          Auth.user = AuthU.CoordinatorModel.fromJson(user);                               // تعيين المستخدم الحالي
          Auth.isLoggedIn(true);                                // تحديث حالة الدخول
          
          // حفظ بيانات الجلسة في التخزين المحلي
          await Constants.storage.write('token', data['token']);        // حفظ token (افتراضي)
          await Constants.storage.write('user', user);            // حفظ بيانات المستخدم
          Auth.isLoading(false);                                // إيقاف التحميل
          Get.offAllNamed(routes.Names.HOME_HOME);
          return;                                            // نجاح العملية
        }
        
        Auth.isLoading(false);
        return;                                             // فشل العملية
      } 
      catch (e) 
      {
        
        if( e is Set) 
        {
          Get.snackbar(Constants.Messages.title.error, {...e, Constants.Messages.server.error}.join('\n')); 
        }
        else 
        {
          Get.snackbar(Constants.Messages.title.error, {e, Constants.Messages.server.error}.join('\n')); 
        }
        Auth.isLoading(false);
        return;
      }
    }
  }
  
}