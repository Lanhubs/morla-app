import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/core/services/app_prefs_service.dart';
import 'package:billkit/routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthTokenStorageService _tokenStorage;
  final CurrentUserController _currentUserController;

  SplashController({
    required AuthTokenStorageService tokenStorage,
    required CurrentUserController currentUserController,
  })  : _tokenStorage = tokenStorage,
        _currentUserController = currentUserController;

  final isLoading = false.obs;

  // --- UI Reactive States for Logo Choreography ---
  final iconScale = 0.0.obs;
  final iconOffsetHorizontal = 0.0.obs; 
  final textOpacity = 0.0.obs;
  final textOffsetHorizontal = 40.0.obs; 

  @override
  void onInit() {
    super.onInit();
    _bootstrapAndAnimate();
  }

  Future<void> _bootstrapAndAnimate() async {
    try {
      // 1. Fire off your backend/storage bootstrap logic immediately in parallel.
      // Do NOT await it yet! Let it crunch data on a separate thread background pool.
      final destinationRouteFuture = _determineDestinationRoute();

      // 2. Phase 1: Icon entrance animation scale pop
      await Future.delayed(const Duration(milliseconds: 150));
      iconScale.value = 1.0;

      // 3. Phase 2: Split translation shift timeline
      await Future.delayed(const Duration(milliseconds: 600));
      iconOffsetHorizontal.value = -70.0; 
      textOffsetHorizontal.value = 0.0;   
      textOpacity.value = 1.0;            

      // 4. Phase 3: Explicitly guarantee the combined logo holds visual layout state
      // for a brief moment so it feels natural to the eye.
      await Future.delayed(const Duration(milliseconds: 1000));

      // 5. Securely wait for our backend authentication route calculation future to finish
      final String targetedDestinationRoute = await destinationRouteFuture;

      // 6. Seamlessly transition routes without ever dropping a frame
      Get.offAllNamed(targetedDestinationRoute);

    } catch (e) {
      print('❌ Splash screen bootstrapping error context: $e');
      final appPrefs = Get.find<AppPrefsService>();
      Get.offAllNamed(appPrefs.isFirstTimeAppOpen ? AppRoutes.onboarding : AppRoutes.login);
    }
  }

  /// Evaluates background application parameters and returns the exact target route string
  Future<String> _determineDestinationRoute() async {
    final token = await _tokenStorage.getToken();
    final appPrefs = Get.find<AppPrefsService>();

    if (token == null || token.isEmpty) {
      return appPrefs.isFirstTimeAppOpen ? AppRoutes.onboarding : AppRoutes.login;
    }

    try {
      // Fetch user data over the network while the icon animations are executing
      await _currentUserController.loadCurrentUser(force: true);
      
      if (_currentUserController.isAuthenticated.value) {
        return AppRoutes.home;
      }
    } catch (e) {
      print('⚠️ Silent load fail during splash validation, routing fallback: $e');
    }

    return appPrefs.isFirstTimeAppOpen ? AppRoutes.onboarding : AppRoutes.login;
  }
}