import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';
import 'package:morla/features/settlement_methods/controllers/settlement_methods_controller.dart';

class EditMethodSheet extends StatelessWidget {
  final PayoutMethodModel method;
  final SettlementMethodsController controller;

  const EditMethodSheet({
    super.key,
    required this.method,
    required this.controller,
  });

  static void show(
    PayoutMethodModel method,
    SettlementMethodsController controller,
  ) {
    Get.bottomSheet(
      EditMethodSheet(method: method, controller: controller),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        side: BorderSide(width: 0)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.darkCanvas,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EDIT ${method.methodType.toUpperCase()} METHOD',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'LABEL',
            style: const TextStyle(
              color: Color(0xFF89938B),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: method.label),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.darkSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SET AS DEFAULT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: method.isDefault,
                onChanged: (val) {
                  // handle switch change logic
                },
                activeThumbColor: AppColors.primaryBlue,
              ),
            ],
          ),
          const SizedBox(height: 32),
          CtaButton(
            text: 'SAVE CHANGES',
            onPressed: () {
              // Implementation to save the edited method
              Get.back();
            },
            type: CtaButtonType.primary,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
