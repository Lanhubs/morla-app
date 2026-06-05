import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:morla/features/clients/widgets/new_client/widgets.dart';
import 'package:morla/features/payment-setup/controllers/payment_setup_controller.dart';
import 'package:morla/features/payment-setup/widgets/chain_selector_bottom_sheet.dart';

class WalletAddressForm extends StatelessWidget {
  final PaymentSetupController controller;
  const WalletAddressForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Network Selector Button
          const Text(
            "Blockchain Network",
            style: TextStyle(
              color: Color(0xFF89938B),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => ChainSelectorBottomSheet.show(controller),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        controller.walletNetwork.value,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                  const Icon(Icons.expand_more, color: Color(0xFF89938B)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Wallet Address Input
          Input(
            hintText: "0x...",
            label: "Destination Receiving Wallet Address",
            onChanged: (val) => controller.walletAddress.value = val,
          ),
          const SizedBox(height: 24),

          // Bind Button
          Align(
            alignment: Alignment.centerRight,
            child: CtaButton(
              type: CtaButtonType.primary,
              text: "[Verify & Bind Wallet]",
              onPressed: controller.bindWallet,
            ),
          ),
        ],
      ),
    );
  }
}
