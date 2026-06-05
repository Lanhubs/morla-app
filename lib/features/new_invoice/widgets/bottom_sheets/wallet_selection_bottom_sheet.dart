import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/features/new_invoice/controllers/new_invoice_controller.dart';
import 'package:morla/core/theme/app_colors.dart';

class WalletSelectionBottomSheet extends StatelessWidget {
  final NewInvoiceController controller;

  const WalletSelectionBottomSheet({super.key, required this.controller});

  static Future<void> show(BuildContext context, NewInvoiceController controller) {
    controller.fetchSavedAccounts();
    return Get.bottomSheet(
      WalletSelectionBottomSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF222B3B)),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select a Wallet Address',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFF334155)),

            Obx(() {
              if (controller.isFetchingAccounts.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primaryBlue),
                  ),
                );
              }

              if (controller.savedWallets.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No saved wallets found',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    ),
                  ),
                );
              }

              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.savedWallets.length,
                  itemBuilder: (context, index) {
                    final wallet = controller.savedWallets[index];
                    final isSelected = controller.selectedWallet.value == wallet;
                    
                    return InkWell(
                      onTap: () {
                        controller.selectedWallet.value = wallet;
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: isSelected ? AppColors.primaryBlue : const Color(0xFF94A3B8),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                wallet,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check, color: AppColors.primaryBlue, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            const Divider(height: 1, color: Color(0xFF334155)),

            // Manage Payment Setup Button
            InkWell(
              onTap: () {
                Get.back();
                Get.toNamed('/paymentSetup');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                child: const Text(
                  'Manage Settlement Channels',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
