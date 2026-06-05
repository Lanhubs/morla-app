import 'package:get/get.dart';
import 'package:morla/features/login/controllers/forgot_password_email_controller.dart';

class ForgotPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordEmailController());
  }
}
