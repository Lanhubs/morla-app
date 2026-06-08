import 'package:get/get.dart';
import 'package:billkit/core/services/auth_dependency.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/features/sign-up/controllers/verify_email_controller.dart';
import 'package:billkit/features/sign-up/data/repositories/sign_up_repository.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    Get.put(
      VerifyEmailEmailController(
        repository: Get.find<SignUpRepository>(),
        tokenStorage: Get.find<AuthTokenStorageService>(),
      ),
    );
  }
}
