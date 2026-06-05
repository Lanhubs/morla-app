import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/app_api_client.dart';
import 'package:morla/core/services/auth_token_storage_service.dart';
import 'package:morla/features/sign-up/data/repositories/sign_up_repository.dart';

class AuthDependency {
  static void ensureRegistered() {
    if (!Get.isRegistered<AuthTokenStorageService>()) {
      Get.put(const AuthTokenStorageService(), permanent: true);
    }

    if (!Get.isRegistered<AppApiClient>()) {
      Get.put(
        AppApiClient.create(
          tokenStorageService: Get.find<AuthTokenStorageService>(),
        ),
        permanent: true,
      );
    }

    if (!Get.isRegistered<SignUpRepository>()) {
      Get.put(
        SignUpRepository(apiClient: Get.find<AppApiClient>()),
        permanent: true,
      );
    }

    if (!Get.isRegistered<CurrentUserController>()) {
      Get.put(
        CurrentUserController(
          repository: Get.find<SignUpRepository>(),
          tokenStorage: Get.find<AuthTokenStorageService>(),
        ),
        permanent: true,
      );
    }
  }
}
