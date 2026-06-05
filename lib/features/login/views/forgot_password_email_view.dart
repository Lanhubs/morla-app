import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/widgets/auth_button.dart';
import 'package:morla/core/widgets/auth_title.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:morla/core/widgets/input.dart';
import 'package:morla/features/login/controllers/forgot_password_email_controller.dart';
import 'package:morla/routes/app_routes.dart';

class ForgotPasswordEmailView extends GetView<ForgotPasswordEmailController> {
  const ForgotPasswordEmailView({super.key});

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
                title: 'Reset your\npassword',
                type: TitleType.h1,
                color: TitleColor.light,
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter your email address and we\'ll send you a verification code.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 48),
              Input(
                hintText: 'Your email address',
                label: 'Email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const Spacer(),
              CtaButton(
                onPressed: controller.sendOtp,
                text: 'Send verification code',
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
