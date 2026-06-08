import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/auth_button.dart';
import 'package:billkit/core/widgets/auth_title.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:billkit/core/widgets/pin_input.dart';
import 'package:billkit/features/login/controllers/forgot_password_otp_controller.dart';
import 'package:billkit/routes/app_routes.dart';

class ForgotPasswordOtpView extends GetView<ForgotPasswordOtpController> {
  const ForgotPasswordOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 24.0,
            bottom: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.lightSurface,
                        ),
                        Text(
                          'back',
                          style: TextStyle(
                            color: AppColors.lightSurface,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AuthButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    text: 'Log in',
                    isOutlined: true,
                  ),
                ],
              ),
              const SizedBox(height: 64),
              AuthTitle(
                title: 'Verify your\nemail',
                type: TitleType.h1,
                color: TitleColor.light,
              ),
              const SizedBox(height: 12),
              Obx(
                () => Text(
                  'We\'ve sent a 6-digit verification code to ${controller.email}.',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              PinInput(
                label: 'Verification Code',
                length: 6,
                controllers: controller.pinControllers,
                focusNodes: controller.focusNodes,
                onChanged: (value) => controller.otp.value = value,
                onCompleted: (value) => controller.verifyOtp(),
              ),
              const Spacer(),
              CtaButton(
                onPressed: controller.verifyOtp,
                text: 'Confirm code',
                type: CtaButtonType.primary,
                radius: RadiusType.full,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
