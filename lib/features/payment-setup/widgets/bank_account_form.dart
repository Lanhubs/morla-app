import 'package:flutter/material.dart';
import 'package:morla/features/clients/widgets/new_client/widgets.dart';
import 'package:morla/features/payment-setup/controllers/payment_setup_controller.dart';

class BankAccountForm extends StatelessWidget {
  final PaymentSetupController controller;
  const BankAccountForm({super.key, required this.controller});

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
          // Account Number
          Input(
            hintText: "00000000000",
            label: "Account Number",
            onChanged: (val) => controller.accountNumber.value = val,
          ),
          const SizedBox(height: 16),

          // Account Name
          Input(
            hintText: "name on the account",
            label: "Account Name",
            onChanged: (val) => controller.accountName.value = val,
          ),
          const SizedBox(height: 16),

          // Bank Name
          Input(
            hintText: "Gt Bank",
            label: "Bank Name",
            onChanged: (val) => controller.bankName.value = val,
          ),
          const SizedBox(height: 24),

          // Link Button
          Align(
            alignment: Alignment.centerRight,
            child: CtaButton(
              type: CtaButtonType.outlined,
              text: "[Add Bank Account]",
              onPressed: controller.addNewAccount,
            ),
          ),
        ],
      ),
    );
  }
}
