import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart' as routes;
import '../../../controllers/controllers.dart' 
  as controllers show 
    Auth, 
    Event, 
    Task, EventMember;
import '../../../../data/models/models.dart' 
  as models show 
    EventModel;

import '../../../widgets/widgets.dart' 
  as widgets show 
    AppBar, 
    TaskCard, 
    LoadingWidget, 
    EmptyWidget;
import '../events_page.dart' show MembersEvent;


part 'detail_other_parts.dart';
part 'detail_event_tasks.dart';
part 'detail_event_members.dart';
part 'detail_event.dart';

// صفحة تفاصيل الحدث
class DetailEvent extends GetView<controllers.Event>
{
  final taskController = Get.find<controllers.Task>();
  final controllers.EventMember eventMemberController = Get.find<controllers.EventMember>();

  final models.EventModel _event = models.EventModel(
      id: 0,
      name: 'حدث غير معروف',
      startDate: DateTime.now(),
      userId: 0,
      createdAt: DateTime.now(),
    );

  models.EventModel get event => Get.arguments ?? _event;

  DetailEvent({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth(() {
    taskController.fetchEventTasks(event.id);
    eventMemberController.fetchEventMembers(event.id);
    controller.fetchEvents();


  return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[50],
                  child: Column(
                    children: [
                      _buildEventInfo(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildTasksTab(),    // تبويب المهام
              _buildMembersTab(),  // تبويب الأعضاء
              _buildDetailsTab(),  // تبويب التفاصيل
            ],
          ),
        ),
      ),
    );
  });

}