part of 'routes.dart';

// فئة لتحديد مسارات التطبيق (Routing)
class Pages 
{
  static const INITIAL = Names.AUTH_LOGIN;                             // الصفحة الابتدائية

  static final routes = 
  [
    // تعريف جميع مسارات التطبيق
    GetPage(
      name: Names.AUTH_LOGIN,                                          // اسم المسار
      page: () => AuthPage.Login(),                                 // الصفحة المرتبطة
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),
    
    GetPage(
      name: Names.AUTH_REGISTER,
      page: () => AuthPage.Register(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

    GetPage(
      name: Names.HOME_HOME,
      page: () => HomePage.IndexHome(),
      binding: BindingsBuilder(() 
      {
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
        Get.lazyPut<controllers.Event>(() => controllers.Event());
        Get.lazyPut<controllers.Task>(() => controllers.Task());
      }),
    ),

    GetPage(
      name: Names.EVENTS_INDEX,
      page: () => EventsPage.IndexEvent(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
        Get.lazyPut<controllers.Event>(() => controllers.Event());
      }),
    ),

    GetPage(
      name: Names.EVENTS_DATAIL,
      page: () => EventsPage.DetailEvent(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Event>(() => controllers.Event());
        Get.lazyPut<controllers.Task>(() => controllers.Task());
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());

      }),
    ),

    GetPage(
      name: Names.EVENTS_CREATE,
      page: () => EventsPage.CreateEvent(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Event>(() => controllers.Event());
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

    GetPage(
      name: Names.EVENTS_MEMBERS,
      page: () => EventsPage.MembersEvent(event: Get.arguments),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.EventMember>(() => controllers.EventMember());
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

    GetPage(
      name: Names.TASKS_INDEX,
      page: () => TasksPage.IndexTask(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
        Get.lazyPut<controllers.Task>(() => controllers.Task());
      }),
    ),

    GetPage(
      name: Names.TASKS_DATAIL,
      page: () => TasksPage.DetailTask(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
        Get.lazyPut<controllers.Task>(() => controllers.Task());
        
      }),
    ),

    GetPage(
      name: Names.TASKS_CREATE,
      page: () => TasksPage.CreateTask(),
       binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Task>(() => controllers.Task());
        Get.lazyPut<controllers.Event>(() => controllers.Event());
        Get.lazyPut<controllers.EventMember>(() => controllers.EventMember());
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

    GetPage(
      name: Names.PROFILE_INDEX,
      page: () => ProfilePage.IndexProfile(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
        Get.lazyPut<controllers.Event>(() => controllers.Event());
        Get.lazyPut<controllers.Task>(() => controllers.Task());
        Get.lazyPut<controllers.User>(() => controllers.User());
      }),
    ),

    GetPage(
      name: Names.PROFILE_CHANGE_PASSWORD,
      page: () => ProfilePage.ChangePasswordProfile(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

    GetPage(
      name: Names.PROFILE_UPDATE,
      page: () => ProfilePage.UpdateProfile(),
      binding: BindingsBuilder(() 
      {                            // ربط الـControllers المطلوبة
        Get.lazyPut<controllers.Auth>(() => controllers.Auth());
      }),
    ),

  ];
}