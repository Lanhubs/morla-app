import 'package:billkit/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Verified path configuration

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A), // Deep Canvas Slate Base
      body: Center(
        child: Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 1. THE TWIN SCALING CHEVRONS (Icon Layer)
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut, // Authentic premium spring pop look
                transform: Matrix4.identity()
                  ..scale(controller.iconScale.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves
                      .easeInOutCubic, // Mature translation shift deceleration
                  transform: Matrix4.identity()
                    ..translate(controller.iconOffsetHorizontal.value, 0.0),
                  child: SvgPicture.asset(
                    'assets/svg/billkit_icon.svg',
                    width: 75,
                    height: 75,
                  ),
                ),
              ),

              // 2. THE STATELY WORDMARK (BILLKIT Text Layer)
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves
                    .easeOutCubic, // FIX: Replaced with an elite, smooth deceleration curve
                transform: Matrix4.identity()
                  ..translate(
                    controller.iconOffsetHorizontal.value == 0.0
                        ? 0.0
                        : controller.iconOffsetHorizontal.value +
                              115.0 +
                              controller.textOffsetHorizontal.value,
                    4.0, // Keeps text vertically aligned with the vector horizon line
                  ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 550),
                  opacity: controller.textOpacity.value,
                  child: SvgPicture.asset(
                    'assets/svg/billkit_wordmark.svg',
                    width: 155,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
