import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/home_controller.dart';
import '../../../core/routes/app_routes.dart';

// import 'package:get/get.dart';
// import '../../../core/routes/app_routes.dart';
// import '../../../logic/controllers/auth_controller.dart';
// import '../../../logic/controllers/home_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'لوحة التحكم',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.primary,
            ),
            onPressed: () =>
                Get.toNamed(AppRoutes.incomes), // Placeholder for notifications
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.accent),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildStatsRow(),
              const SizedBox(height: 32),
              const Text(
                'الخدمات السريعة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildServiceItem(
                    'المنسقين',
                    Icons.assignment_ind_outlined,
                    AppRoutes.coordinators,
                  ),
                  _buildServiceItem(
                    'الموردين',
                    Icons.storefront_outlined,
                    AppRoutes.suppliers,
                  ),
                  _buildServiceItem(
                    'الخدمات',
                    Icons.category_outlined,
                    AppRoutes.services,
                  ),
                  _buildServiceItem(
                    'العملاء',
                    Icons.people_outline,
                    AppRoutes.clients,
                  ),
                  _buildServiceItem(
                    'المناسبات',
                    Icons.calendar_today_outlined,
                    AppRoutes.events,
                  ),
                  _buildServiceItem(
                    'المهام',
                    Icons.task_alt_outlined,
                    AppRoutes.tasks,
                  ),
                  _buildServiceItem(
                    'الدخل',
                    Icons.account_balance_wallet_outlined,
                    AppRoutes.incomes,
                  ),
                  _buildServiceItem(
                    'الإعدادات',
                    Icons.settings_outlined,
                    AppRoutes.home,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحباً بك،',
          style: TextStyle(color: AppColors.textSubtitle, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'أحمد المنسق', // This could be dynamic from authController.user
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            'المناسبات النشطة',
            '12',
            Icons.celebration,
            AppColors.primary,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            'مهام اليوم',
            '5',
            Icons.pending_actions,
            AppColors.secondary,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            'إجمالي الدخل',
            '45K',
            Icons.trending_up,
            Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return GlassCard(
      width: 150,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textSubtitle),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, IconData icon, String route) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Get.toNamed(route),
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
