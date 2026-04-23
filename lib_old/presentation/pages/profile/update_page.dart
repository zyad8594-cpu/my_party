part of 'profile_page.dart';

// صفحة التسجيل كمستخدم جديد
class UpdateProfile extends GetView<controllers.Auth>
{

  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    controller.fileds.change.restAll();
    controller.fileds.change.nameUpdate(controllers.Auth.userAuth().name);
    controller.fileds.change.emailUpdate(controllers.Auth.userAuth().email);

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
       
               // حقل اسم المستخدم
              TextField(
                controller: TextEditingController(text: controllers.Auth.userAuth().name),
                onChanged: controller.fileds.change.nameUpdate,
                
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // حقل البريد الإلكتروني
              TextField(
                controller: TextEditingController(text: controllers.Auth.userAuth().email),
                onChanged: controller.fileds.change.emailUpdate,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),
               // حقل البريد الإلكتروني
              if(controllers.Auth.userAuth().role == "coordinator") ...[TextField(
                onChanged: controller.fileds.change.roleUpdate,
                decoration: const InputDecoration(
                  labelText: 'الصلاحية',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20)],
              // 
              
              // زر الحفظ
              Obx(() => controller.isLoading()
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.updateProfile,

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