import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/auth_title.dart';
import 'package:billkit/core/widgets/auth_button.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:billkit/core/widgets/input.dart';
import 'package:billkit/features/sign-up/controllers/signup_controller.dart';
import 'package:billkit/routes/app_routes.dart';

class SignUpView extends GetView<SignupController> {
  const SignUpView({super.key});

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AuthButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    text: "Log in",
                    isOutlined: true,
                  ),
                ],
              ),
              const SizedBox(height: 64),
              AuthTitle(
                title: "Create your\naccount",
                type: TitleType.h1,
                color: TitleColor.light,
              ),
              Text(
                "Manage your invoices, track payments, and get paid faster. ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: const Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 48),
              Input(
                hintText: "Your email address",
                label: "Email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const Spacer(),
              CtaButton(
                onPressed: controller.signUp,
                text: "Sign up",
                type: CtaButtonType.primary,
                radius: RadiusType.full,
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "By clicking continue, you acknowledge that you have read and agreed to our ",
                    ),
                    TextSpan(
                      text: "Privacy policy",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "terms of service",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
