import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart' as controllers 
    show Auth, Task, User;
import '../../../../data/models/models.dart' as models 
  show TaskModel;
import '../../../widgets/widgets.dart' as widgets show AppBar;

part 'detail_appbar.dart';
part 'detail_build_statusSection.dart';
part 'detail_build_dates_section.dart';
part 'detail_build_date_item.dart';
part 'detail_build_description_section.dart';
part 'detail_build_assignees_section.dart';
part 'detail_build_assignee_item.dart';
part 'detail_build_actions_section.dart';
part 'detail_build_action_button.dart';
part 'detail_change_task_status.dart';
part 'detail_other_parts.dart';

// صفحة تفاصيل المهمة
class DetailTask extends GetView<controllers.Task>
{
  final userController = Get.find<controllers.User>();
  final models.TaskModel _task = models.TaskModel(
    id: 0,
    eventId: 0,
    title: 'مهمة غير معروفة',
    status: 'pending',
    createdAt: DateTime.now(),
  );

  models.TaskModel get task => Get.arguments ?? _task;

  DetailTask({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    controller.fetchTasks();
    return Scaffold(
      appBar: _appBar(),
      
      body: Obx(()=> SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان المهمة
              ..._buildTitle(),
              
              // حالة المهمة
              ..._buildStatusSection(),
              
              // تواريخ المهمة
              ..._buildDatesSection(),
              
              // وصف المهمة
              ... _buildDescriptionSection(),
              
              // المعينون
              ..._buildAssigneesSection(),
              
              // الإجراءات
              ..._buildActionsSection(),
            ],
          ),
        ),
      ),
    );
  });

}