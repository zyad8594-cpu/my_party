import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isError ? Colors.red : Colors.green,
    colorText: Colors.white,
    margin: const EdgeInsets.all(8),
  );
}

void showLoading() {
  Get.dialog(
    const Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
  );
}

void hideLoading() {
  if (Get.isDialogOpen ?? false) Get.back();
}