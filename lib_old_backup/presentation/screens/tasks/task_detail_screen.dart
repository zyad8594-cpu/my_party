import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/task.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_card.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Task task = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(title: task.typeTask),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusHeader(task),
              const SizedBox(height: 32),
              _buildDetailSection(task),
              const SizedBox(height: 32),
              _buildDescriptionSection(task),
              const SizedBox(height: 40),
              _buildActionButtons(task),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader(Task task) {
    Color statusColor;
    switch (task.status.toUpperCase()) {
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

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment_outlined, color: statusColor, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.typeTask,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    _getStatusText(task.status),
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildDetailSection(Task task) {
    return Column(
      children: [
        _buildDetailItem(Icons.event_outlined, 'المناسبة', task.eventName ?? 'غير محدد'),
        const SizedBox(height: 16),
        _buildDetailItem(
          Icons.person_outline, 
          task.assignmentType == 'SUPPLIER' ? 'المورد المسؤول' : 'المستخدم المسؤول', 
          (task.assignmentType == 'SUPPLIER' ? task.supplierName : task.userName) ?? 'غير معين'
        ),
        const SizedBox(height: 16),
        _buildDetailItem(Icons.calendar_today_outlined, 'تاريخ الاستحقاق', task.dateDue ?? 'غير محدد'),
        const SizedBox(height: 16),
        _buildDetailItem(Icons.attach_money_outlined, 'التكلفة المقدرة', '${task.cost ?? 0} ريال'),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textSubtitle, fontSize: 12)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(Task task) {
    return GlassCard(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('الوصف والملاحظات', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Text(
            task.description ?? 'لا يوجد وصف متاح لهذه المهمة.',
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
          if (task.notes != null && task.notes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: Colors.white12),
            const SizedBox(height: 16),
            const Text('ملاحظات إضافية', style: TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(task.notes!, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(Task task) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            label: const Text('تعديل'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('إكمال'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
