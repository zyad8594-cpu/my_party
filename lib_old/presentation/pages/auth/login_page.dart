part of 'auth_page.dart';

// صفحة تسجيل الدخول
class Login extends GetView<controllers.Auth>
{
 const Login({super.key});

  @override
  Widget build(BuildContext context) 
  {
    controller.fileds.login.restAll();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widgets.AppBar(
        title: 'تسجيل الدخول', 
        showBackButton: false, 
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // حقل إدخال البريد الإلكتروني
            TextField(
                onChanged: controller.fileds.login.email,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,         // لوحة مفاتيح خاصة بالبريد
              ),
            
            
            const SizedBox(height: 20),                         // مسافة بين الحقول
            
            // حقل إدخال كلمة المرور
            widgets.TextPasswordField(
              controller: controller, 
              name: 'loginPass',
              update: controller.fileds.login.password,
            ),
            
            
            const SizedBox(height: 30),
            
            // زر تسجيل الدخول
            Obx(() => controller.isLoading()
                ? const CircularProgressIndicator()             // عرض دائرة تحميل أثناء التحميل
                : 
                ElevatedButton(
                    onPressed: () async 
                    {
                      await controller.login();                      
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50), // زر بعرض كامل
                    ),
                    child: const Text('تسجيل الدخول'),
                  ),
            ),
            
            const SizedBox(height: 20),
            
            // رابط الانتقال لصفحة التسجيل
            TextButton(
              // الانتقال لصفحة التسجيل
              onPressed: () => Get.toNamed(routes.Names.AUTH_REGISTER),
              child: const Text('ليس لديك حساب؟ سجل الآن'),
            ),

            const SizedBox(height: 20),
            const Text('تسجيل الدخول ب'),
            Obx(()=>  controller.isLoading()
                ? const CircularProgressIndicator()             // عرض دائرة تحميل أثناء التحميل
                : TextButton(
                // الانتقال لصفحة التسجيل
                onPressed: () async 
                { 
                  // استدعاء دالة تسجيل الدخول
                  controller.fileds.login.email("admin@gmail.com");
                  controller.fileds.login.password("admin1234");
                  await controller.login();
                },
                child: const Text('admin@gmail.com'),
              ),
            ),

            Obx(()=>  controller.isLoading()
                ? const CircularProgressIndicator()             // عرض دائرة تحميل أثناء التحميل
                : TextButton(
                // الانتقال لصفحة التسجيل
                onPressed: () async 
                { 
                  // استدعاء دالة تسجيل الدخول
                  controller.fileds.login.email("user@gmail.com");
                  controller.fileds.login.password("user1234");
                  await controller.login();
                  
                },
                child: const Text('user@gmail.com'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}