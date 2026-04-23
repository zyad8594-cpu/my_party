part of 'auth_controller.dart';

extension UpdateProfile on Auth
{
  static Future<void> updateProfile() async
  {
    if(Auth.isLoading() == false)
    {
      try 
      {
        
        

        Auth.isLoading(true);
        // إنشاء نموذج المستخدم
        final user = Auth.user!.copyWith(
          full_name: Auth.name.value.trim(),
          email: Auth.email.value.trim(),
        );

        final nupdateUser = await AuthService.updateProfile(user);
        if(nupdateUser != null)
        {
          Auth.isLoading(false);
          Get.snackbar(Constants.Messages.title.success, Constants.Messages.update.success);     // رسالة
          Get.offAllNamed(routes.Names.PROFILE_INDEX);
          return;
        }
        else 
        {
          Auth.isLoading(false);
          throw [Constants.Messages.update.error];
        }
        
      } 
      catch (e) 
      {
        Auth.isLoading(false);
        Get.snackbar(Constants.Messages.title.error, [...(e as List<String>), Constants.Messages.request.error].join('\n'));
        return;
      }
    }
  }
}