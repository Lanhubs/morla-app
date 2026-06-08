import 'package:get/get.dart';
import 'package:billkit/features/login/controllers/forgot_password_otp_controller.dart';

class ForgotPasswordOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordOtpController());
  }
}
