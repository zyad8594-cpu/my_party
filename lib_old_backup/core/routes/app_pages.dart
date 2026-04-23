import 'package:get/get.dart';
import 'app_routes.dart';

import '../../presentation/bindings/auth_binding.dart';
import '../../presentation/bindings/client_binding.dart';
import '../../presentation/bindings/coordinator_binding.dart';
import '../../presentation/bindings/event_binding.dart';
import '../../presentation/bindings/home_binding.dart';
import '../../presentation/bindings/income_binding.dart';
import '../../presentation/bindings/notification_binding.dart';
import '../../presentation/bindings/service_binding.dart';
import '../../presentation/bindings/supplier_binding.dart';
import '../../presentation/bindings/task_binding.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/clients/client_list_screen.dart';
import '../../presentation/screens/coordinators/coordinator_detail_screen.dart';
import '../../presentation/screens/coordinators/coordinator_list_screen.dart';
import '../../presentation/screens/events/event_detail_screen.dart';
import '../../presentation/screens/suppliers/supplier_detail_screen.dart';
import '../../presentation/screens/tasks/task_detail_screen.dart';
import '../../presentation/screens/events/event_list_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/incomes/income_list_screen.dart';
import '../../presentation/screens/services/service_list_screen.dart';
import '../../presentation/screens/suppliers/supplier_list_screen.dart';
import '../../presentation/screens/tasks/task_list_screen.dart';

import '../../presentation/screens/notifications/notification_list_screen.dart';
// import '../../core/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.coordinators,
      page: () => CoordinatorListScreen(),
      binding: CoordinatorBinding(),
    ),
    GetPage(
      name: AppRoutes.coordinatorDetail,
      page: () => const CoordinatorDetailScreen(),
      binding: CoordinatorBinding(),
    ),
    GetPage(
      name: AppRoutes.suppliers,
      page: () => SupplierListScreen(),
      binding: SupplierBinding(),
    ),
    GetPage(
      name: AppRoutes.supplierDetail,
      page: () => const SupplierDetailScreen(),
      binding: SupplierBinding(),
    ),
    GetPage(
      name: AppRoutes.services,
      page: () => ServiceListScreen(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: AppRoutes.clients,
      page: () => ClientListScreen(),
      binding: ClientBinding(),
    ),
    GetPage(
      name: AppRoutes.events,
      page: () => EventListScreen(),
      binding: EventBinding(),
    ),
    GetPage(
      name: AppRoutes.eventDetail,
      page: () => const EventDetailScreen(),
      binding: EventBinding(),
    ),
    GetPage(
      name: AppRoutes.tasks,
      page: () => TaskListScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.taskDetail,
      page: () => TaskDetailScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.incomes,
      page: () => IncomeListScreen(),
      binding: IncomeBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationListScreen(),
      binding: NotificationBinding(),
    ),
  ];
}
