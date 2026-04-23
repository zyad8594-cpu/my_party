import 'package:get/get.dart';

class HomeController extends GetxController {
  // يمكن إضافة إحصائيات أو بيانات للصفحة الرئيسية
  final stats = {
    'coordinators': 0,
    'suppliers': 0,
    'events': 0,
    'tasks': 0,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    // يمكن جلب الإحصائيات من API
  }
}