import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/auth_dependency.dart';
import 'package:morla/core/services/auth_token_storage_service.dart';
import 'package:morla/features/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    Get.put(
      SplashController(
        tokenStorage: Get.find<AuthTokenStorageService>(),
        currentUserController: Get.find<CurrentUserController>(),
      ),
    );
  }
}
