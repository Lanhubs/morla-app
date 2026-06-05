import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackHelper {
  static void showSuccess(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: Colors.green.withValues(alpha: .1),
      colorText: Colors.green,
      borderColor: Colors.green,
      borderWidth: 1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.up,
    );
  }

  static void showError(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: Colors.red.withValues(alpha: .1),
      colorText: Colors.red,
      borderColor: Colors.red,
      borderWidth: 1,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 3),
    );
  }

  static void showInfo(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: Colors.blue.withValues(alpha: .1),
      colorText: Colors.blue,
      borderColor: Colors.blue,
      borderWidth: 1,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 3),
    );
  }
  static void showWarning(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: Colors.orange.withValues(alpha: .1),
      colorText: Colors.orange,
      borderColor: Colors.orange,
      borderWidth: 1,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 3),
    );
  }
}
