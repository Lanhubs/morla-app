import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';

class AutomatedPingsSection extends StatelessWidget {
  const AutomatedPingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkSurfaceStroke, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.mail_outline, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Automated Email Pings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.invoice.value == null) return const SizedBox.shrink();
                return Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: true, // Placeholder for backend support
                    activeTrackColor: AppColors.primaryBlue,
                    onChanged: (_) {},
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Trigger Manual SMS Reminder Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
