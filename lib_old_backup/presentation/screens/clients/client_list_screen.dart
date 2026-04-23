import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_party/data/models/client.dart';
import 'package:my_party/logic/controllers/client_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class ClientListScreen extends StatelessWidget {
  ClientListScreen({super.key});

  final ClientController controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'قائمة العملاء'),
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
          if (controller.clients.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.clients.length,
            itemBuilder: (context, index) {
              final client = controller.clients[index];
              return _buildClientCard(client);
            },
          );
        }),
      ),
    );
  }

  Widget _buildClientCard(Client client) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person_outline, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.fullName.isNotEmpty ? client.fullName : 'عميل بدون اسم',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    client.phoneNumber.isNotEmpty ? client.phoneNumber : 'بدون رقم هاتف',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSubtitle),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 18),
                  onPressed: () => _showForm(client: client),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.accent, size: 18),
                  onPressed: () => _delete(client.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: AppColors.textSubtitle.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'لا يوجد عملاء مضافين',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showForm({Client? client}) {
    final nameCtrl = TextEditingController(text: client?.fullName);
    final phoneCtrl = TextEditingController(text: client?.phoneNumber);
    final emailCtrl = TextEditingController(text: client?.email);
    final addressCtrl = TextEditingController(text: client?.address);

    Get.bottomSheet(
      isScrollControlled: true,
      GlassCard(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              Text(
                client == null ? 'إضافة عميل جديد' : 'تعديل بيانات العميل',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'الاسم الكامل', prefixIcon: Icon(Icons.person_outline)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف', prefixIcon: Icon(Icons.phone_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressCtrl,
                decoration: const InputDecoration(labelText: 'العنوان', prefixIcon: Icon(Icons.location_on_outlined)),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: client == null ? 'إضافة' : 'حفظ التعديلات',
                onPressed: () {
                  final data = {
                    'full_name': nameCtrl.text,
                    'phone_number': phoneCtrl.text,
                    'email': emailCtrl.text,
                    'address': addressCtrl.text,
                  };
                  if (client == null) {
                    controller.createClient(data);
                  } else {
                    controller.updateClient(client.id, data);
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
      middleText: 'هل أنت متأكد من حذف هذا العميل؟',
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: AppColors.surface,
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.black,
      cancelTextColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.deleteClient(id);
      },
    );
  }
}