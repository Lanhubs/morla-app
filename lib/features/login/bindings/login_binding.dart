import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/services/auth_dependency.dart';
import 'package:morla/features/login/controllers/login_controller.dart';
import 'package:morla/features/sign-up/data/repositories/sign_up_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    AuthDependency.ensureRegistered();

    Get.lazyPut<LoginController>(
      () => LoginController(
        repository: Get.find<SignUpRepository>(),
        currentUserController: Get.find<CurrentUserController>(),
      ),
    );
  }
}
