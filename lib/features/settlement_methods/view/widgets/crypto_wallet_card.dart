import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/settlement_methods/data/models/payout_method_model.dart';

class CryptoWalletCard extends StatelessWidget {
  final PayoutMethodModel method;
  final VoidCallback onTap;

  const CryptoWalletCard({
    super.key,
    required this.method,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.currency_bitcoin,
                  color: AppColors.primaryBlue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  method.label.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.05),
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                method.walletAddress ?? 'Unknown Address',
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
