import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/widgets/auth_title.dart';
import 'package:billkit/core/widgets/auth_button.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:billkit/core/widgets/input.dart';
import 'package:billkit/core/widgets/google_sign_in_button.dart';
import 'package:billkit/features/login/controllers/login_controller.dart';
import 'package:billkit/routes/app_routes.dart';
import 'package:billkit/core/services/app_prefs_service.dart';
import 'package:billkit/core/widgets/or_divider.dart';
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    text: "Create Account",
                    isOutlined: true,
                  ),
                ],
              ),
              const SizedBox(height: 64),
              AuthTitle(
                title: Get.find<AppPrefsService>().hasLoggedInBefore
                    ? "Welcome back!\nLog in to your account"
                    : "Log in to your\naccount",
                type: TitleType.h1,
                color: TitleColor.light,
              ),
              Text(
                Get.find<AppPrefsService>().hasLoggedInBefore
                    ? "Continue where you left off. Everythings is secured"
                    : "Securely access your invoices, clients and payments",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.questrial().fontFamily,
                  color: Colors.white,
                ),
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
                onPressed: () => controller.login(),
                text: "Log in",
                type: CtaButtonType.primary,
                radius: RadiusType.full,
              ),
              const SizedBox(height: 16),
              OrDivider(),
              const SizedBox(height: 16),
              Obx(
                () => GoogleSignInButton(
                  onPressed: () => controller.signInWithGoogle(),
                  isLoading: controller.isGoogleLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

