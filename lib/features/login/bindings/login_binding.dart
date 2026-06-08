import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/services/auth_dependency.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/core/services/google_auth_service.dart';
import 'package:billkit/features/login/controllers/login_controller.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:billkit/features/login/data/repositories/oauth_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    // Register OAuth repository
    Get.lazyPut<OAuthRepository>(() => OAuthRepository());

    Get.lazyPut<LoginController>(
      () => LoginController(
        repository: Get.find<SignUpRepository>(),
        oauthRepository: Get.find<OAuthRepository>(),
        currentUserController: Get.find<CurrentUserController>(),
        googleAuthService: Get.find<GoogleAuthService>(),
        tokenStorage: Get.find<AuthTokenStorageService>(),
      ),
    );
  }
}
