import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/auth_controller.dart';
import '../../widgets/custom_app_bar.dart';
// import '../../widgets/loading_widget.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'إنشاء حساب'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background),
        child: Stack(
          children: [
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withValues(alpha: 0.1),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'انضم إلينا',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ابدأ بتنظيم مناسباتك بشكل أسهل',
                      style: TextStyle(color: AppColors.textSubtitle),
                    ),
                    const SizedBox(height: 40),
                    GlassCard(
                      child: Column(
                        children: [
                          TextField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              labelText: 'الاسم الكامل',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'رقم الهاتف',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: controller.passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'كلمة المرور',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => DropdownButtonFormField<String>(
                              value: controller.selectedRole.value,
                              dropdownColor: AppColors.surface,
                              decoration: const InputDecoration(
                                labelText: 'نوع الحساب',
                                prefixIcon: Icon(Icons.category_outlined),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'coordinator',
                                  child: Text('منسق حفلات'),
                                ),
                                DropdownMenuItem(
                                  value: 'supplier',
                                  child: Text('مزود خدمات'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedRole.value = value;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          Obx(
                            () => GradientButton(
                              text: 'إنشاء حساب',
                              isLoading: controller.isLoading.value,
                              onPressed: controller.register,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: RichText(
                        text: const TextSpan(
                          text: 'لديك حساب بالفعل؟ ',
                          style: TextStyle(color: AppColors.textSubtitle),
                          children: [
                            TextSpan(
                              text: 'قم بتسجيل الدخول',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
