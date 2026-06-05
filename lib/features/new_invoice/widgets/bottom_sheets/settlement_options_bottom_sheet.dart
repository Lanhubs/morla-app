import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/new_invoice/controllers/new_invoice_controller.dart';

import 'settlement_options/merchant_card.dart';
import 'settlement_options/settlement_tabs.dart';
import 'settlement_options/crypto_pane.dart';
import 'settlement_options/fiat_pane.dart';
import 'settlement_options/verification_section.dart';
import 'package:morla/routes/app_routes.dart';

class SettlementOptionsPage extends StatelessWidget {
  final NewInvoiceController controller;

  const SettlementOptionsPage({super.key, required this.controller});

  static Future<void> show(BuildContext context, NewInvoiceController controller) {
    return Get.to(
      () => SettlementOptionsPage(controller: controller),
      transition: Transition.cupertino,
      fullscreenDialog: true,
    ) ?? Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                          color: AppColors.primaryBlue.withValues(alpha: 0.2),
                        ),
                        child: const Icon(Icons.receipt_long, color: AppColors.primaryBlue, size: 16),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Billing Terminal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.settlementMethods),
                        icon: const Icon(Icons.settings, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  final activeTab = controller.activeSettlementTab.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MerchantCard(controller: controller),
                      const SizedBox(height: 16),
                      SettlementTabs(
                        activeTab: activeTab,
                        onTabChanged: (tab) => controller.activeSettlementTab.value = tab,
                      ),
                      const SizedBox(height: 16),
                      if (activeTab == 'crypto') CryptoPane(controller: controller),
                      if (activeTab == 'fiat') FiatPane(controller: controller),
                      if (activeTab == 'crypto') ...[
                        const SizedBox(height: 32),
                        const VerificationSection(),
                      ],
                      const SizedBox(height: 40),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Backwards-compatible alias so existing call sites don't need to change.
typedef SettlementOptionsBottomSheet = SettlementOptionsPage;

