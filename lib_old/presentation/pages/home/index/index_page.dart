import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart' as routes;
import '../../../controllers/controllers.dart' 
  as controllers show 
    Auth, 
    Event, 
    Task;

import '../../../widgets/widgets.dart' 
  as widgets show 
    AppBar, 
    EventCard, 
    Drawer,
    TaskCard;

part 'index_other_parts.dart';

// الصفحة الرئيسية للتطبيق
class IndexHome extends GetView<controllers.Event>
{
  final taskController = Get.find<controllers.Task>();

  IndexHome({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth(() {
    return Scaffold(
      appBar: widgets.AppBar(showBackButton: false,),
      drawer: widgets.Drawer(selectedIndex: 0),
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            // ترحيب بالمستخدم
            ..._buildUserWelcome(),
            
            // إحصائيات سريعة
            ..._buildShortStatistics(),
            
            // قسم الأحداث القريبة
            ..._buildTasksOrEventsSections(routes.Names.EVENTS_INDEX),
            
            // قائمة الأحداث
            ..._buildTasksOrEventsList(),
            
            // // قسم المهام العاجلة
            // ..._buildCardSections(routes.Names.TASKS_INDEX),
            
            // // قائمة المهام
            // ..._buildTasksOrEventsList(true),
          ],
        ),
      
      ),
    );
  });
}
