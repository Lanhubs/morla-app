import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';
import 'package:morla/features/dashboard/controllers/home_controller.dart';
import 'package:morla/features/home/widgets/bottom_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      extendBody: true,
      body: LiquidGlassView(
        backgroundWidget: Obx(() => controller.tabs[controller.currentIndex.value]),
        children: [
          buildLiquidGlassBottomBar(controller),
        ],
      ),
    );
  }
}