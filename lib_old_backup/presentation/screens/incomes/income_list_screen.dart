import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_party/data/models/income.dart';
import 'package:my_party/logic/controllers/income_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class IncomeListScreen extends StatelessWidget {
  IncomeListScreen({super.key});

  final IncomeController controller = Get.find<IncomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'المدخولات والمدفوعات'),
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
          if (controller.incomes.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.incomes.length,
            itemBuilder: (context, index) {
              final income = controller.incomes[index];
              return _buildIncomeCard(income);
            },
          );
        }),
      ),
    );
  }

  Widget _buildIncomeCard(Income income) {
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
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.attach_money, color: Colors.green, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${income.amount} ريال',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    income.eventName ?? 'بدون مناسبة',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSubtitle),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  income.paymentDate.isNotEmpty 
                      ? DateFormat('yyyy-MM-dd').format(DateTime.tryParse(income.paymentDate) ?? DateTime.now())
                      : 'التاريخ غير متوفر',
                  style: const TextStyle(fontSize: 10, color: AppColors.textSubtitle),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 18),
                      onPressed: () => _showForm(income: income),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.accent, size: 18),
                      onPressed: () => _delete(income.id),
                    ),
                  ],
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
          Icon(Icons.monetization_on_outlined, size: 80, color: AppColors.textSubtitle.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'لا توجد بيانات مالية حالياً',
            style: TextStyle(color: AppColors.textSubtitle, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showForm({Income? income}) {
    final amountCtrl = TextEditingController(text: income?.amount.toString());
    final methodCtrl = TextEditingController(text: income?.paymentMethod);
    final descCtrl = TextEditingController(text: income?.description);

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
                income == null ? 'إضافة مبلغ جديد' : 'تعديل البيانات المالية',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'المبلغ', prefixIcon: Icon(Icons.attach_money_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: methodCtrl,
                decoration: const InputDecoration(labelText: 'طريقة الدفع', prefixIcon: Icon(Icons.payment_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'الوصف / ملاحظات', prefixIcon: Icon(Icons.description_outlined)),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: income == null ? 'إضافة' : 'حفظ التعديلات',
                onPressed: () {
                  final data = {
                    'amount': double.tryParse(amountCtrl.text) ?? 0.0,
                    'payment_method': methodCtrl.text,
                    'description': descCtrl.text,
                    'payment_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    'event_id': income?.eventId ?? 1, // Placeholder
                  };
                  if (income == null) {
                    controller.createIncome(data);
                  } else {
                    controller.updateIncome(income.id, data);
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
      middleText: 'هل أنت متأكد من حذف هذه البيانات؟',
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: AppColors.surface,
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.black,
      cancelTextColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.deleteIncome(id);
      },
    );
  }
}