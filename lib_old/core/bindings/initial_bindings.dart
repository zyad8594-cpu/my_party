import 'package:get/get.dart';
import '../../data/services/services.dart' as services;
import '../../presentation/controllers/controllers.dart' as controllers;


// فئة لربط التبعيات (Dependency Injection) باستخدام GetX
class InitialBindings extends Bindings 
{
  @override
  void dependencies() 
  {
    // تسجيل الـServices كـsingletons (instance واحدة خلال دورة حياة التطبيق)
    Get.lazyPut<services.ApiService>(() => services.ApiService());           // خدمة API الأساسية
    Get.lazyPut<services.CoordinatorService>(() => services.CoordinatorService());         // خدمة المستخدمين
    Get.lazyPut<services.EventService>(() => services.EventService());       // خدمة الأحداث
    Get.lazyPut<services.TaskService>(() => services.TaskService());         // خدمة المهام

    // تسجيل الـControllers
    Get.lazyPut<controllers.Auth>(() => controllers.Auth());   // controller المصادقة
    Get.lazyPut<controllers.User>(() => controllers.User(), fenix: true);   // controller المستخدمين
    Get.lazyPut<controllers.Event>(() => controllers.Event()); // controller الأحداث
    Get.lazyPut<controllers.Task>(() => controllers.Task());   // controller المهام
    Get.lazyPut<controllers.TaskAssign>(() => controllers.TaskAssign());
    Get.lazyPut<controllers.EventMember>(() => controllers.EventMember(), fenix: true);   
  }
}

