import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';

class TransactionHashSection extends StatelessWidget {
  const TransactionHashSection({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Hash',
            style: TextStyle(
              color: AppColors.textMutedDark,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFF131A2A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF94A3B8), width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.link, color: AppColors.textMutedDark, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() {
                    if (controller.invoice.value == null) return const SizedBox.shrink();
                    return const Text(
                      '0x71C7658EC7ab88b098defB751B7401B5f6d...', // Placeholder for now
                      style: TextStyle(
                        color: AppColors.textMutedDark,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
