import 'package:get/get.dart';
import 'package:billkit/core/services/auth_dependency.dart';
import 'package:billkit/features/sign-up/controllers/signup_controller.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    final controller = Get.isRegistered<SignupController>()
        ? Get.find<SignupController>()
        : Get.put(
            SignupController(
              repository: Get.find<SignUpRepository>(),
              tokenStorage: Get.find<AuthTokenStorageService>(),
            ),
          );

    controller.hydrateFromRouteArguments(Get.arguments);
  }
}
