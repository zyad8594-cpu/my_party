import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart' as routes;
import '../../../controllers/controllers.dart' as controllers show Auth, Task;
import '../../../widgets/widgets.dart' as widgets show AppBar, TaskCard, LoadingWidget, Drawer, EmptyWidget;

part 'index_other_parts.dart';

// صفحة عرض قائمة جميع المهام
class IndexTask extends GetView<controllers.Task> 
{ 
  const IndexTask({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth(() {
     controller.fetchTasks();
    return Scaffold(
      appBar: widgets.AppBar(title: 'المهام'),
      drawer: widgets.Drawer(selectedIndex: 3),
      body: Column(
        children: [
          // شريط التصفية
          _buildFilterBar(),

          const SizedBox(height: 8),
          
          // قائمة المهام
          _listTasks(),
        ],
      ),
      floatingActionButton: _floatingButton(),
    );
  });
  
}