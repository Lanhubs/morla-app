import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:morla/routes/app_routes.dart';

class LoginController extends GetxController {
  final SignUpRepository _repository;
  final CurrentUserController _currentUserController;

  LoginController({
    required SignUpRepository repository,
    required CurrentUserController currentUserController,
  }) : _repository = repository,
       _currentUserController = currentUserController;

  final emailController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim().toLowerCase();

    if (!GetUtils.isEmail(email)) {
      _showError('Please enter a valid email address');
      return;
    }

    isLoading.value = true;

    try {
      await _repository.requestOtp(email: email);
      Get.toNamed(
        AppRoutes.verify,
        arguments: {'email': email, 'authFlow': 'login'},
      );
    } catch (error) {
      _showError(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> hasValidSession() async {
    await _currentUserController.loadCurrentUser(force: true);
    return _currentUserController.isAuthenticated.value;
  }

  void _showError(String message) {
     SnackHelper.showError(
       message,
        title:'Error',
        
        );
  
  }
}
