import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/supplier.dart';
import 'package:my_party/logic/controllers/supplier_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class SupplierListScreen extends StatelessWidget {
  SupplierListScreen({super.key});

  final SupplierController controller = Get.find<SupplierController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'قائمة الموردين'),
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
          if (controller.suppliers.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.suppliers.length,
            itemBuilder: (context, index) {
              final supplier = controller.suppliers[index];
              return _buildSupplierCard(supplier);
            },
          );
        }),
      ),
    );
  }

  Widget _buildSupplierCard(Supplier supplier) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () => Get.toNamed('/supplier-detail', arguments: supplier),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.storefront_outlined, color: Colors.black, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      supplier.email,
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
                    onPressed: () => _showForm(supplier: supplier),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.accent, size: 20),
                    onPressed: () => _delete(supplier.id),
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
          Icon(Icons.store_mall_directory_outlined, size: 80, color: AppColors.textSubtitle.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'لا يوجد موردين حالياً',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showForm({Supplier? supplier}) {
    final nameCtrl = TextEditingController(text: supplier?.name);
    final emailCtrl = TextEditingController(text: supplier?.email);
    final phoneCtrl = TextEditingController(text: supplier?.phone);
    final notesCtrl = TextEditingController(text: supplier?.notes);

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
                supplier == null ? 'إضافة مورد جديد' : 'تعديل بيانات المورد',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'اسم المورد',
                  prefixIcon: Icon(Icons.store_outlined),
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
              const SizedBox(height: 16),
              TextField(
                controller: notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'ملاحظات',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: supplier == null ? 'إضافة' : 'حفظ التعديلات',
                onPressed: () {
                  final data = {
                    'name': nameCtrl.text,
                    'email': emailCtrl.text,
                    'phone_number': phoneCtrl.text,
                    'notes': notesCtrl.text,
                  };
                  if (supplier == null) {
                    controller.createSupplier(data);
                  } else {
                    controller.updateSupplier(supplier.id, data);
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
      middleText: 'هل أنت متأكد من حذف هذا المورد؟',
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: AppColors.surface,
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.black,
      cancelTextColor: AppColors.primary,
      buttonColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.deleteSupplier(id);
      },
    );
  }
}