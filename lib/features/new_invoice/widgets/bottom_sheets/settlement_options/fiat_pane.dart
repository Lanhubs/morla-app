import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/cta_button.dart';
import 'package:billkit/features/new_invoice/controllers/new_invoice_controller.dart';

class FiatPane extends StatelessWidget {
  final NewInvoiceController controller;

  const FiatPane({super.key, required this.controller});

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
        final selectedFiatAccount = controller.selectedFiatAccount.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'FIAT ACCOUNT',
                  style: TextStyle(
                    color: Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final toggling = !controller.isEnteringNewFiatAccount.value;
                    controller.isEnteringNewFiatAccount.value = toggling;
                    if (!toggling && controller.savedFiatAccounts.isNotEmpty) {
                      controller.selectedFiatAccount.value =
                          controller.savedFiatAccounts.first;
                    }
                  },
                  child: Text(
                    controller.isEnteringNewFiatAccount.value
                        ? 'CHOOSE SAVED'
                        : 'ENTER NEW',
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (controller.isEnteringNewFiatAccount.value) ...[
              const FiatInputLabel(label: 'CARDHOLDER NAME'),
              const SizedBox(height: 4),
              const FiatTextField(hint: 'ALEXANDER VANCE'),

              const SizedBox(height: 12),
              const FiatInputLabel(label: 'CARD NUMBER'),
              const SizedBox(height: 4),
              const FiatTextField(
                hint: '**** **** **** 8829',
                icon: Icons.credit_card,
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FiatInputLabel(label: 'EXPIRY'),
                        const SizedBox(height: 4),
                        const FiatTextField(hint: 'MM / YY'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FiatInputLabel(label: 'CVC'),
                        const SizedBox(height: 4),
                        const FiatTextField(hint: '***'),
                      ],
                    ),
                  ),
                ],
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: AppColors.darkSurface,
                    value:
                        controller.savedFiatAccounts.contains(
                          selectedFiatAccount,
                        )
                        ? selectedFiatAccount
                        : null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryBlue,
                    ),
                    items: controller.savedFiatAccounts.map((account) {
                      return DropdownMenuItem<String>(
                        value: account,
                        child: Text(
                          account,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        controller.selectedFiatAccount.value = val;
                      }
                    },
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),
            CtaButton(
              text: controller.isCreating
                  ? 'AUTHORIZING...'
                  : 'AUTHORIZE \$${controller.grandTotal.toStringAsFixed(2)}',
              onPressed: controller.isCreating
                  ? null
                  : () {
                      controller.submitInvoice(
                        settlementMethod: 'fiat',
                        settlementAsset: 'CARD',
                      );
                    },
              icon: Icons.lock,
              type: CtaButtonType.primary,
              width: double.infinity,
            ),
          ],
        );
      }),
    );
  }
}

class FiatInputLabel extends StatelessWidget {
  final String label;

  const FiatInputLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF89938B),
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

class FiatTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;

  const FiatTextField({super.key, required this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF89938B)),
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF89938B))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF404943)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF404943)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBlue),
        ),
      ),
    );
  }
}
