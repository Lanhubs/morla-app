import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/routes/app_routes.dart';

class ForgotPasswordOtpController extends GetxController {
  final otp = ''.obs;
  late final String email;
  late final List<TextEditingController> pinControllers;
  late final List<FocusNode> focusNodes;

  @override
  void onInit() {
    super.onInit();
    email = (Get.arguments as Map<String, dynamic>?)?['email'] as String? ?? '';
    pinControllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void onClose() {
    for (final controller in pinControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void verifyOtp() {
    if (otp.value.length != 6) {
      
      SnackHelper.showError(
        'Please enter the 6-digit verification code',
       title: 'Invalid Code',
       
      );
      return;
    }

    Get.toNamed(
      AppRoutes.forgotPasswordReset,
      arguments: {'email': email, 'otp': otp.value},
    );
  }
}
