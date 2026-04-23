// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'core/bindings/initial_bindings.dart';
// import 'core/core.dart' as Constents show Config, Theme;
// import 'routes/routes.dart' as routes;
import 'window_manager_init.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/app_bindings.dart';
import 'package:my_party/core/constants/app_constants.dart';
import 'package:my_party/routes/app_routes.dart';


void main() async {
  await windowManagerInit(size: Size(400, 700));
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  // تهيئة الخدمات قبل تشغيل التطبيق
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => ApiService().init());
  Get.put(AuthService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      initialBinding: AppBindings(),
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
      ),
    );
  }
}