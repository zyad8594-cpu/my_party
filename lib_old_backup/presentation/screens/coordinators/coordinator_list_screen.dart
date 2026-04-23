import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/coordinator.dart';
import '../../../logic/controllers/coordinator_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class CoordinatorListScreen extends StatelessWidget {
  CoordinatorListScreen({super.key});

  final CoordinatorController controller = Get.find<CoordinatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'قائمة المنسقين'),
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
          if (controller.coordinators.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.coordinators.length,
            itemBuilder: (context, index) {
              final coordinator = controller.coordinators[index];
              return _buildCoordinatorCard(coordinator);
            },
          );
        }),
      ),
    );
  }

  Widget _buildCoordinatorCard(Coordinator coordinator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () => Get.toNamed('/coordinator-detail', arguments: coordinator),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    coordinator.fullName.isNotEmpty 
                        ? coordinator.fullName.substring(0, 1).toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coordinator.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coordinator.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
                    onPressed: () => _showForm(coordinator: coordinator),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.accent, size: 20),
                    onPressed: () => _delete(coordinator.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 80, color: AppColors.textSubtitle.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'لا يوجد منسقين حالياً',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showForm({Coordinator? coordinator}) {
    final fullNameCtrl = TextEditingController(text: coordinator?.fullName);
    final emailCtrl = TextEditingController(text: coordinator?.email);
    final phoneCtrl = TextEditingController(text: coordinator?.phoneNumber);
    final passwordCtrl = TextEditingController();

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
                coordinator == null ? 'إضافة منسق جديد' : 'تعديل بيانات المنسق',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: fullNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              if (coordinator == null) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              GradientButton(
                text: coordinator == null ? 'إضافة' : 'حفظ التعديلات',
                onPressed: () {
                  final data = {
                    'full_name': fullNameCtrl.text,
                    'email': emailCtrl.text,
                    'phone_number': phoneCtrl.text,
                    if (coordinator == null) 'password': passwordCtrl.text,
                  };
                  if (coordinator == null) {
                    controller.createCoordinator(data);
                  } else {
                    controller.updateCoordinator(coordinator.id, data);
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
      middleText: 'هل أنت متأكد من حذف هذا المنسق؟',
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: AppColors.surface,
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.black,
      cancelTextColor: AppColors.primary,
      buttonColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.deleteCoordinator(id);
      },
    );
  }
}