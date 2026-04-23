part of 'detail_page.dart';

extension on DetailTask
{
  // تغيير حالة المهمة
  void _changeTaskStatus(models.TaskModel task, String newStatus) {
    Get.defaultDialog(
      title: 'تغيير الحالة',
      middleText: 'هل تريد تغيير حالة المهمة إلى ${_getStatusText(newStatus)}؟',
      textConfirm: 'تغيير',
      textCancel: 'إلغاء',
      onConfirm: () async 
      {
        await controller.changeTaskStatus(task.id, newStatus);
        Get.back();
        Get.snackbar('نجاح', 'تم تغيير حالة المهمة');
      },
    );
  }
  
}