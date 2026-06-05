import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/auth_token_storage_service.dart';
import 'package:morla/core/services/app_prefs_service.dart';
import 'package:morla/routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthTokenStorageService _tokenStorage;
  final CurrentUserController _currentUserController;

  SplashController({
    required AuthTokenStorageService tokenStorage,
    required CurrentUserController currentUserController,
  }) : _tokenStorage = tokenStorage,
       _currentUserController = currentUserController;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await _tokenStorage.getToken();
    final appPrefs = Get.find<AppPrefsService>();

    if (token == null || token.isEmpty) {
      if (appPrefs.isFirstTimeAppOpen) {
        Get.offAllNamed(AppRoutes.onboarding);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
      return;
    }

    await _currentUserController.loadCurrentUser(force: true);

    if (_currentUserController.isAuthenticated.value) {
      Get.offAllNamed(AppRoutes.home);
      return;
    }

    if (appPrefs.isFirstTimeAppOpen) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}

