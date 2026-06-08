import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/core/services/app_prefs_service.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:billkit/routes/app_routes.dart';

class VerifyEmailEmailController extends GetxController {
  final SignUpRepository _repository;
  final AuthTokenStorageService _tokenStorage;

  VerifyEmailEmailController({
    required SignUpRepository repository,
    required AuthTokenStorageService tokenStorage,
  }) : _repository = repository,
       _tokenStorage = tokenStorage;

  final otp = ''.obs;
  final email = ''.obs;
  final authFlow = 'signup'.obs;
  final isLoading = false.obs;

  final List<TextEditingController> pinControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final emailArg = args['email'];
      final flowArg = args['authFlow'];

      if (emailArg is String) {
        email.value = emailArg;
      }

      if (flowArg is String && flowArg.isNotEmpty) {
        authFlow.value = flowArg;
      }
    }
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

  Future<void> verifyEmail() async {
    if (otp.value.length != 6) {
      _showError('Please enter a valid 6-digit code');
      return;
    }

    final currentEmail = email.value.trim().toLowerCase();
    if (currentEmail.isEmpty) {
      _showError('Please restart from signup/login step');
      return;
    }

    if (authFlow.value == 'login') {
      isLoading.value = true;

      try {
        final session = await _repository.verifyOtp(
          email: currentEmail,
          code: otp.value,
        );
        await _tokenStorage.saveToken(session.accessToken);
        await Get.find<AppPrefsService>().setHasLoggedInBefore(true);

        if (Get.isRegistered<CurrentUserController>()) {
          Get.find<CurrentUserController>().setCurrentUser(session.user);
        }

        Get.offAllNamed(AppRoutes.home);
      } catch (error) {
        _showError(error.toString().replaceFirst('Exception: ', ''));
      } finally {
        isLoading.value = false;
      }

      return;
    }

    Get.toNamed(
      AppRoutes.finalStep,
      arguments: {'email': currentEmail, 'otp': otp.value},
    );
  }

  void _showError(String message) {
     SnackHelper.showError(
              message,
              title: "Error",
            );
  
  }
}
