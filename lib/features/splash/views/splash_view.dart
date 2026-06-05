import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Morla',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
