import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/utils/snack_helper.dart';
import 'package:billkit/core/services/google_auth_service.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:billkit/features/login/data/repositories/oauth_repository.dart';
import 'package:billkit/routes/app_routes.dart';

class LoginController extends GetxController {
  final SignUpRepository _repository;
  final OAuthRepository _oauthRepository;
  final CurrentUserController _currentUserController;
  final GoogleAuthService _googleAuthService;
  final AuthTokenStorageService _tokenStorage;

  LoginController({
    required SignUpRepository repository,
    required OAuthRepository oauthRepository,
    required CurrentUserController currentUserController,
    required GoogleAuthService googleAuthService,
    required AuthTokenStorageService tokenStorage,
  }) : _repository = repository,
       _oauthRepository = oauthRepository,
       _currentUserController = currentUserController,
       _googleAuthService = googleAuthService,
       _tokenStorage = tokenStorage;

  final emailController = TextEditingController();
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;

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

  Future<void> signInWithGoogle() async {
    isGoogleLoading.value = true;

    try {
      // Sign in with Google
      final account = await _googleAuthService.signIn();

      if (account == null) {
        _showError('Google sign-in was cancelled');
        return;
      }

      // Get ID token
      final idToken = await _googleAuthService.getIdToken();

      if (idToken == null) {
        _showError('Failed to get authentication token');
        return;
      }

      // Authenticate with backend
      final response = await _oauthRepository.authenticateWithGoogle(
        idToken: idToken,
        deviceInfo: {'platform': 'mobile'},
      );

      // Save token
      await _tokenStorage.saveToken(response.accessToken);

      // Load user data
      await _currentUserController.loadCurrentUser(force: true);

      // Navigate based on profile completion
      if (response.isNewUser) {
        // New user - complete profile
        Get.offAllNamed(
          AppRoutes.finalStep,
          arguments: {
            'email': response.user.email,
            'fullName': response.user.fullName,
            'fromGoogle': true,
          },
        );
      } else {
        // Existing user - go to home
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (error) {
      _showError(error.toString().replaceFirst('Exception: ', ''));
      await _googleAuthService.signOut();
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<bool> hasValidSession() async {
    await _currentUserController.loadCurrentUser(force: true);
    return _currentUserController.isAuthenticated.value;
  }

  void _showError(String message) {
    SnackHelper.showError(message, title: 'Error');
  }
}
