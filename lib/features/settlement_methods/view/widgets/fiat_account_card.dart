import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/settlement_methods/data/models/payout_method_model.dart';

class FiatAccountCard extends StatelessWidget {
  final PayoutMethodModel method;
  final VoidCallback onTap;

  // Use RxBool for toggling visibility without converting the widget to stateful
  final RxBool _isObscured = true.obs;

  FiatAccountCard({super.key, required this.method, required this.onTap});

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  method.label.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  method.bankName ?? 'Unknown Bank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 8,
                top: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => Text(
                        _isObscured.value
                            ? '•••• •••• •••• ${method.accountNumber != null && method.accountNumber!.length >= 4 ? method.accountNumber!.substring(method.accountNumber!.length - 4) : '****'}'
                            : (method.accountNumber ?? ''),
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 14,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _isObscured.value = !_isObscured.value,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.primaryBlue.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Obx(
                        () => Text(
                          _isObscured.value ? '[REVEAL]' : '[HIDE]',
                          style: const TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
