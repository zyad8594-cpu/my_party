import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/supplier.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_card.dart';

class SupplierDetailScreen extends StatelessWidget {
  const SupplierDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Supplier supplier = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(title: supplier.name),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(supplier),
              const SizedBox(height: 32),
              _buildInfoSection(supplier),
              const SizedBox(height: 40),
              _buildActions(context, supplier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Supplier supplier) {
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
          child: const Center(
            child: Icon(Icons.store_mall_directory_outlined, size: 64, color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          supplier.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          'مزود خدمات معتمد',
          style: TextStyle(color: AppColors.primary, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildInfoSection(Supplier supplier) {
    return Column(
      children: [
        _buildInfoCard(Icons.email_outlined, 'البريد الإلكتروني', supplier.email),
        const SizedBox(height: 16),
        _buildInfoCard(Icons.phone_outlined, 'رقم الهاتف', supplier.phone),
        const SizedBox(height: 16),
        _buildInfoCard(Icons.notes_outlined, 'ملاحظات', supplier.notes ?? 'لا توجد ملاحظات'),
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
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, Supplier supplier) {
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
