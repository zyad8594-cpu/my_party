import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/coordinator.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_card.dart';

class CoordinatorDetailScreen extends StatelessWidget {
  const CoordinatorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Coordinator coordinator = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(title: coordinator.fullName),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(coordinator),
              const SizedBox(height: 32),
              _buildInfoSection(coordinator),
              const SizedBox(height: 40),
              _buildActions(context, coordinator),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Coordinator coordinator) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              coordinator.fullName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          coordinator.fullName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          'منسق حفلات معتمد',
          style: TextStyle(color: AppColors.primary, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildInfoSection(Coordinator coordinator) {
    return Column(
      children: [
        _buildInfoCard(Icons.email_outlined, 'البريد الإلكتروني', coordinator.email),
        const SizedBox(height: 16),
        _buildInfoCard(Icons.phone_outlined, 'رقم الهاتف', coordinator.phoneNumber ?? 'لا يوجد'),
        const SizedBox(height: 16),
        _buildInfoCard(Icons.calendar_today_outlined, 'تاريخ الانضمام', 'مارس 2024'), // Mocked date
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.textSubtitle, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, Coordinator coordinator) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 18),
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
            icon: const Icon(Icons.message_outlined, size: 18),
            label: const Text('مراسلة'),
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
