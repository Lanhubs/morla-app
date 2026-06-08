import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:billkit/features/new_invoice/controllers/new_invoice_controller.dart';
import 'package:billkit/features/new_invoice/widgets/bottom_sheets/wallet_selection_bottom_sheet.dart';

class CryptoPane extends StatelessWidget {
  final NewInvoiceController controller;

  const CryptoPane({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final selectedAsset = controller.selectedCryptoAsset.value;
        final selectedWallet = controller.selectedWallet.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SELECT ASSET',
                  style: TextStyle(
                    color: Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.primaryBlue.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ERC-20',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'TRC-20',
                        style: TextStyle(
                          color: Color(0xFF89938B),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedCryptoAsset.value = 'USDC',
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedAsset == 'USDC'
                            ? AppColors.primaryBlue.withValues(alpha: 0.05)
                            : Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: selectedAsset == 'USDC'
                              ? AppColors.primaryBlue.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: selectedAsset == 'USDC'
                                  ? AppColors.primaryBlue
                                  : Colors.grey[700],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'S',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'USDC',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedCryptoAsset.value = 'USDT',
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedAsset == 'USDT'
                            ? AppColors.primaryBlue.withValues(alpha: 0.05)
                            : Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: selectedAsset == 'USDT'
                              ? AppColors.primaryBlue.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: selectedAsset == 'USDT'
                                  ? AppColors.primaryBlue
                                  : Colors.grey[700],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'T',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'USDT',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  width: 160,
                  height: 160,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: selectedWallet.isNotEmpty
                      ? QrImageView(
                          data: selectedWallet,
                          version: QrVersions.auto,
                          size: 160.0,
                        )
                      : const Icon(
                          Icons.qr_code_2,
                          size: 100,
                          color: Colors.black87,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Scan to pay with any Web3 wallet',
                style: TextStyle(color: Color(0xFF89938B), fontSize: 14),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                '0.3421 ETH / 12,450 USDC',
                style: TextStyle(color: AppColors.primaryBlue, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'WALLET ADDRESS',
                  style: TextStyle(
                    color: Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => WalletSelectionBottomSheet.show(context, controller),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.selectedWallet.value.isNotEmpty
                            ? controller.selectedWallet.value
                            : 'Select a wallet...',
                        style: TextStyle(
                          color: controller.selectedWallet.value.isNotEmpty
                              ? Colors.white
                              : const Color(0xFF89938B),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            CtaButton(
              text: controller.isCreating
                  ? 'CONFIRMING...'
                  : 'CONFIRM SETTLEMENT',
              onPressed: controller.isCreating
                  ? null
                  : () {
                      controller.submitInvoice(
                        settlementMethod: 'crypto',
                        settlementAsset: selectedAsset,
                      );
                    },
              type: CtaButtonType.primary,
              width: double.infinity,
            ),
          ],
        );
      }),
    );
  }
}
