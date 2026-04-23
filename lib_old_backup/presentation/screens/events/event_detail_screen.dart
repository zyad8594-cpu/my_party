import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/event.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_card.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Event event = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(title: event.nameEvent),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEventHeader(event),
              const SizedBox(height: 32),
              const Text(
                'تفاصيل المناسبة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoSection(event),
              const SizedBox(height: 32),
              _buildDescription(event),
              const SizedBox(height: 40),
              _buildActions(context, event),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventHeader(Event event) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.celebration, color: AppColors.primary, size: 40),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.nameEvent,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                DateFormat('EEEE, MMM dd, yyyy').format(DateTime.parse(event.eventDate)),
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(Event event) {
    return Column(
      children: [
        _buildInfoCard(Icons.location_on_outlined, 'الموقع', event.location ?? 'غير محدد'),
        const SizedBox(height: 12),
        _buildInfoCard(Icons.attach_money_outlined, 'الميزانية', '${event.budget ?? 0} ريال'),
        const SizedBox(height: 12),
        _buildInfoCard(Icons.person_outline, 'العميل', 'محمد علي'), // Mocked data
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.textSubtitle, fontSize: 10),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(Event event) {
    return GlassCard(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الوصف والملاحظات',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            event.description ?? 'لا يوجد وصف مضاف لهذه المناسبة.',
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, Event event) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_note, size: 18),
            label: const Text('تعديل'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.checklist_rtl, size: 18),
            label: const Text('المهام'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
