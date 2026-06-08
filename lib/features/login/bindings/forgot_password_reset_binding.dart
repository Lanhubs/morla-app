import 'package:get/get.dart';
import 'package:billkit/features/login/controllers/forgot_password_reset_controller.dart';

class ForgotPasswordResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordResetController());
  }
}
