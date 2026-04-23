part of 'profile_page.dart';

// صفحة التسجيل كمستخدم جديد
class ChangePasswordProfile extends GetView<controllers.Auth>
{

  const ChangePasswordProfile({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    controller.fileds.change.restAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغيير كلمة المرور"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
       
              
              // حقل كلمة المرور الحالية
              widgets.TextPasswordField(
                  controller: controller, 
                  name: 'changePassCurrent',
                  update: controller.fileds.change.currentPass,
              ),
              

              const SizedBox(height: 20),

              // حقل كلمة المرور الجديدة
              widgets.TextPasswordField(
                  controller: controller, 
                  label: 'كلمة المرور الجديدة',
                  name: 'changePassNew',
                  update: controller.fileds.change.newPass
              ),
              

              const SizedBox(height: 20),

              // حقل تأكيد كلمة المرور
              widgets.TextPasswordField(
                controller: controller, 
                label: 'تأكيد كلمة المرور',
                prefixIcon: Icons.lock_outline,
                name: 'changePassConfirm',
                update: controller.fileds.change.confirmPass,
              ),              

              const SizedBox(height: 30),
              
              // زر الحفظ
              Obx(() => controller.isLoading()
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.changePassword,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('حفظ'),
                    ),
              ),
              
             

              
            ],
          ),
        ),
      ),
    );
  });
}