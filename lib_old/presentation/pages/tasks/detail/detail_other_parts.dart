part of 'detail_page.dart';

extension on DetailTask{
  
  List<Widget> _buildTitle()
  {
    return [
      Text(
        task.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
    ];
  }
  // معالجة إجراءات القائمة
  void _handleMenuAction(String action, models.TaskModel task) {
    switch (action) {
      case 'edit':
        _editTask(task);
        break;
      case 'delete':
        _deleteTask(task);
        break;
      case 'share':
        _shareTask(task);
        break;
    }
  }

  // تعديل المهمة
  void _editTask(models.TaskModel task) {
    Get.toNamed('/task/create', arguments: task);
  }

  // حذف المهمة
  void _deleteTask(models.TaskModel task) {
    Get.defaultDialog(
      title: 'حذف المهمة',
      middleText: 'هل أنت متأكد من حذف هذه المهمة؟',
      textConfirm: 'حذف',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final success = await controller.deleteTask(task.id);
        if (success) {
          Get.back();
          Get.back(); // العودة للصفحة السابقة
        }
      },
    );
  }

  // مشاركة المهمة
  void _shareTask(models.TaskModel task) {
   
    Get.snackbar('مشاركة', 'تم نسخ رابط المهمة');
  }

  // الحصول على نص الحالة
  String _getStatusText(String status) {
    switch (status) {
      case 'completed': return 'مكتملة';
      case 'in_progress': return 'قيد التنفيذ';
      default: return 'معلقة';
    }
  }

  // تنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}