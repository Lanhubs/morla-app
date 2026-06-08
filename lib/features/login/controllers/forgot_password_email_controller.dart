import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/routes/app_routes.dart';

class ForgotPasswordEmailController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendOtp() {
    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      SnackHelper.showError(
        'Please enter a valid email address',
        title: 'Invalid Email',
      );
      return;
    }

    Get.toNamed(AppRoutes.forgotPasswordVerify, arguments: {'email': email});
  }
}
