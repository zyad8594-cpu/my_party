part of 'auth_page.dart';

// صفحة التسجيل كمستخدم جديد
class Register extends GetView<controllers.Auth>
{

  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fileds.register.restAll();
    return Scaffold(
      appBar: widgets.AppBar(
        title: 'إنشاء حساب جديد', 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              // حقل اسم المستخدم
              TextField(
                onChanged: controller.fileds.register.name,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // حقل البريد الإلكتروني
              TextField(
                onChanged: controller.fileds.register.email,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 20),
              
              // حقل كلمة المرور
              widgets.TextPasswordField(
                  controller: controller, 
                  name: 'registerPass',
                  update: controller.fileds.register.password,
                ),
              

              const SizedBox(height: 20),
              
              // حقل تأكيد كلمة المرور
              widgets.TextPasswordField(
                controller: controller, 
                label: 'تأكيد كلمة المرور',
                prefixIcon: Icons.lock_outline,
                name: 'registerConfirm',
                update: controller.fileds.register.confirmPass,
              ),              

              const SizedBox(height: 30),
              
              // زر التسجيل
              Obx(() => controller.isLoading()
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.register,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('إنشاء حساب'),
                    ),
              ),
              
              const SizedBox(height: 20),
              
              // رابط العودة لتسجيل الدخول
              TextButton(
                onPressed: Get.back,
                child: const Text('لديك حساب بالفعل؟ سجل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}