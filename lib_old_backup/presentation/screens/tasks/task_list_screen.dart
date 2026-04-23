import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/task.dart';
import 'package:my_party/logic/controllers/task_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});

  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'قائمة المهام'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const LoadingWidget();
          }
          if (controller.tasks.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              return _buildTaskCard(task);
            },
          );
        }),
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    Color statusColor;
    final String status = task.status.toUpperCase();
    switch (status) {
      case 'COMPLETED':
        statusColor = Colors.green;
        break;
      case 'IN_PROGRESS':
        statusColor = Colors.blue;
        break;
      case 'CANCELLED':
        statusColor = AppColors.accent;
        break;
      default:
        statusColor = AppColors.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () => Get.toNamed('/task-detail', arguments: task),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.assignment_outlined, color: statusColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.typeTask,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.eventName ?? 'بدون مناسبة',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      _getStatusText(task.status),
                      style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 18),
                        onPressed: () => _showForm(task: task),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.accent, size: 18),
                        onPressed: () => _delete(task.id),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'قيد الانتظار';
      case 'IN_PROGRESS':
        return 'قيد التنفيذ';
      case 'COMPLETED':
        return 'مكتملة';
      case 'CANCELLED':
        return 'ملغاة';
      default:
        return status;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_turned_in_outlined, size: 80, color: AppColors.textSubtitle.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'لا توجد مهام حالياً',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showForm({Task? task}) {
    final typeCtrl = TextEditingController(text: task?.typeTask);
    final descCtrl = TextEditingController(text: task?.description);
    final costCtrl = TextEditingController(text: task?.cost?.toString());
    final notesCtrl = TextEditingController(text: task?.notes);

    Get.bottomSheet(
      isScrollControlled: true,
      GlassCard(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                task == null ? 'إضافة مهمة جديدة' : 'تعديل المهمة',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: typeCtrl,
                decoration: const InputDecoration(
                  labelText: 'نوع المهمة / العنوان',
                  prefixIcon: Icon(Icons.assignment_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'الوصف',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: costCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'التكلفة',
                  prefixIcon: Icon(Icons.attach_money_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'ملاحظات إضافية',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: task == null ? 'إضافة' : 'حفظ التعديلات',
                onPressed: () {
                  final data = {
                    'type_task': typeCtrl.text,
                    'description': descCtrl.text,
                    'cost': double.tryParse(costCtrl.text) ?? 0.0,
                    'notes': notesCtrl.text,
                    'status': task?.status ?? 'PENDING',
                  };
                  if (task == null) {
                    controller.createTask(data);
                  } else {
                    controller.updateTask(task.id, data);
                  }
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _delete(int id) async {
    Get.defaultDialog(
      title: 'تأكيد الحذف',
      titleStyle: const TextStyle(color: AppColors.primary),
      middleText: 'هل أنت متأكد من حذف هذه المهمة؟',
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: AppColors.surface,
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.black,
      cancelTextColor: AppColors.primary,
      buttonColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.deleteTask(id);
      },
    );
  }
}