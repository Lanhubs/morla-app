import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/routes/app_routes.dart';

class ForgotPasswordResetController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  late final String email;

  @override
  void onInit() {
    super.onInit();
    email = (Get.arguments as Map<String, dynamic>?)?['email'] as String? ?? '';
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void resetPassword() {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.length < 8) {
      SnackHelper.showError(
        'Password must be at least 8 characters long',
        title:'Weak Password',
     
      );
      return;
    }

    if (password != confirmPassword) {

      SnackHelper.showError(
        'Password and confirm password must match',
        title:'Password Mismatch',
        );
      return;
    }
 SnackHelper.showSuccess(
       'Your password has been changed successfully',
        title:'Password Updated',
        
        );
    

    Get.offAllNamed(AppRoutes.login);
  }
}
