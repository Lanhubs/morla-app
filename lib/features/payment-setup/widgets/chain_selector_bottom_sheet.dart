import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/payment-setup/controllers/payment_setup_controller.dart';

class ChainSelectorBottomSheet extends StatelessWidget {
  final PaymentSetupController controller;

  const ChainSelectorBottomSheet({super.key, required this.controller});

  static void show(PaymentSetupController controller) {
    Get.bottomSheet(
      ChainSelectorBottomSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        side: BorderSide(width: 0)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final networks = ['Ethereum', 'Polygon', 'Arbitrum', 'Base'];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkCanvas,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 24, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Network',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...networks.map((network) => ListTile(
                title: Text(
                  network,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                trailing: Obx(() => controller.walletNetwork.value == network
                    ? const Icon(Icons.check_circle, color: AppColors.primaryBlue)
                    : const SizedBox.shrink()),
                onTap: () {
                  controller.walletNetwork.value = network;
                  Get.back();
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              )),
        ],
      ),
    );
  }
}
