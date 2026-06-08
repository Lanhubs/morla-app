import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:billkit/core/widgets/cta_button.dart";
import "package:billkit/routes/app_routes.dart";
import "package:billkit/core/services/app_prefs_service.dart";

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/onboarding.png"),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0, top: 20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      
                      Colors.black,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Invoice your clients. Track what you're owed. Get paid faster.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
        
                    CtaButton(
                      text: "Sign up",
                      type: CtaButtonType.outlined,
                      onPressed: () {
                        Get.find<AppPrefsService>().setFirstTimeAppOpen(false);
                        Get.toNamed(AppRoutes.signup);
                      },
                    ),
                    CtaButton(
                      text: "Log in",
                      type: CtaButtonType.primary,
                      onPressed: () {
                        Get.find<AppPrefsService>().setFirstTimeAppOpen(false);
                        Get.toNamed(AppRoutes.login);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
