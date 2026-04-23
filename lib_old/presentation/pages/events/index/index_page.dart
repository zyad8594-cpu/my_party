import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart' as routes;
import '../../../controllers/controllers.dart' 
  as controllers show 
    Auth, 
    Event;
import '../../../widgets/widgets.dart' 
  as widgets show 
    AppBar, 
    Drawer, 
    EventCard, 
    LoadingWidget, 
    EmptyWidget;


part 'index_other_parts.dart';

// صفحة عرض قائمة جميع الأحداث
class IndexEvent extends GetView<controllers.Event>
{
  const IndexEvent({super.key});
  
  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    
    return Scaffold
    (
      appBar: _appBar(),
      drawer: widgets.Drawer( selectedIndex: 2),
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Column
        (
          children: 
          [
            // شريط البحث والتصفية
            ..._buildSearchFilterBar(),
            
            // قائمة الأحداث
            ..._buildListEvents(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  });
 
}