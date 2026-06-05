import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';
import 'package:morla/features/dashboard/controllers/home_controller.dart';
import 'package:morla/features/home/widgets/nav_item.dart';

LiquidGlass buildLiquidGlassBottomBar(BuildContext context, HomeController controller) {
  final double bottomPadding = MediaQuery.of(context).padding.bottom;
  return LiquidGlass(
    width: Get.width - 32.0, // Screen width minus the left (16) and right (16) margin
    height: 80.0,
    position: LiquidGlassAlignPosition(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
        bottom: bottomPadding > 0 ? bottomPadding + 4.0 : 20.0, 
        left: 16.0, 
        right: 16.0
      ),
    ),
    shape: RoundedRectangleShape(
      cornerRadius: 16.0,
      borderType: OpticalBorder(
        ambientIntensity: 1.2,
      ),
    ),
    color: const Color(0xFFF8FAFC).withValues(alpha: 0.08),
    blur: const LiquidGlassBlur(sigmaX: 12, sigmaY: 12),
    child: Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NavItem(
              title: "Home",
              icon: HugeIcons.strokeRoundedHome01,
              onTap: () => controller.changeTab(0),
              isActive: controller.currentIndex.value == 0,
            ),
            NavItem(
              title: "Clients",
              icon: HugeIcons.strokeRoundedUserMultiple02,
              onTap: () => controller.changeTab(1),
              isActive: controller.currentIndex.value == 1,
            ),
            GestureDetector(
              onTap: () => controller.changeTab(2),
              child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == 2
                      ? const Color(0xFF3B82F6)
                      : Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: controller.currentIndex.value == 2
                      ? Colors.white.withValues(alpha: 0.9)
                      : const Color(0xFF3B82F6),
                ),
              ),
            ),
            NavItem(
              title: "History",
              icon: Icons.history_outlined,
              onTap: () => controller.changeTab(3),
              isActive: controller.currentIndex.value == 3,
            ),
            NavItem(
              title: "Settings",
              icon: HugeIcons.strokeRoundedAccountSetting01,
              onTap: () => controller.changeTab(4),
              isActive: controller.currentIndex.value == 4,
            ),
          ],
        ),
      ),
    ),
  );
}
