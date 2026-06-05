import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/auth_token_storage_service.dart';
import 'package:morla/core/services/app_prefs_service.dart';
import 'package:morla/core/utils/snack_helper.dart';
import 'package:morla/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:morla/routes/app_routes.dart';

class SignupController extends GetxController {
  final SignUpRepository _repository;
  final AuthTokenStorageService _tokenStorage;

  SignupController({
    required SignUpRepository repository,
    required AuthTokenStorageService tokenStorage,
  }) : _repository = repository,
       _tokenStorage = tokenStorage;

  final isLoading = false.obs;
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumber = TextEditingController();

  final RxString _pendingEmail = ''.obs;
  final RxString _pendingOtp = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    fullNameController.dispose();
    phoneNumber.dispose();
    super.onClose();
  }

  void hydrateFromRouteArguments(dynamic args) {
    if (args is! Map<String, dynamic>) {
      return;
    }

    final emailArg = args['email'];
    final otpArg = args['otp'];

    if (emailArg is String && emailArg.isNotEmpty) {
      _pendingEmail.value = emailArg.trim().toLowerCase();
    }

    if (otpArg is String && otpArg.isNotEmpty) {
      _pendingOtp.value = otpArg.trim();
    }
  }

  Future<void> signUp() async {
    final email = emailController.text.trim().toLowerCase();

    if (!GetUtils.isEmail(email)) {
      _showError('Please enter a valid email address');
      return;
    }

    isLoading.value = true;

    try {
      await _repository.requestOtp(email: email);
      _pendingEmail.value = email;
      Get.toNamed(
        AppRoutes.verify,
        arguments: {'email': email, 'authFlow': 'signup'},
      );
    } catch (error) {
      _showError(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeSignUp() async {
    final email = _pendingEmail.value.trim().toLowerCase();
    final otp = _pendingOtp.value.trim();
    final fullName = fullNameController.text.trim();
    final phone = phoneNumber.text.trim();

    if (email.isEmpty) {
      _showError('Missing email. Please restart signup.');
      return;
    }

    if (otp.length != 6) {
      _showError('Invalid verification code.');
      return;
    }

    if (fullName.length < 2) {
      _showError('Please enter your full name');
      return;
    }

    if (phone.isEmpty) {
      _showError('Please enter your phone number');
      return;
    }

    isLoading.value = true;

    try {
      final session = await _repository.verifyOtp(
        email: email,
        code: otp,
        fullName: fullName,
        phone: phone,
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
  }

  void _showError(String message) {
    SnackHelper.showError(
              message,
              title: "Error",
            );
    
  }
}
