import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:my_party/core/routes/app_routes.dart';
import 'package:my_party/core/services/api_service.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/helpers.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final selectedRole = 'coordinator'.obs;

  final isLoading = false.obs;

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar('خطأ', 'يرجى إدخال البريد وكلمة المرور', isError: true);
      return;
    }
    isLoading.value = true;
    try {
      final response = await _authRepository.login(
        emailController.text,
        passwordController.text,
      );
      final token = response['token'];
      final userData = response['user'];
      await _authService.saveAuthData(token, userData);
      Get.find<ApiService>().setToken(token);
      Get.offAllNamed(AppRoutes.home);
      showSnackbar('نجاح', 'تم تسجيل الدخول بنجاح');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showSnackbar('خطأ', 'يرجى ملء جميع الحقول', isError: true);
      return;
    }
    isLoading.value = true;
    try {
      final data = {
        'full_name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'role_name': selectedRole.value,
      };
      // final response = await _authRepository.register(data);
      await _authRepository.register(data);
      Get.back(); // العودة إلى صفحة تسجيل الدخول
      showSnackbar('نجاح', 'تم التسجيل بنجاح، يمكنك تسجيل الدخول الآن');
    } catch (e) {
      showSnackbar('خطأ', e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _authService.logout();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
