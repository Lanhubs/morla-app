import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/invoice_details/controllers/invoice_details_controller.dart';

class ShareInvoiceButton extends StatelessWidget {
  const ShareInvoiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Obx(() {
      if (controller.invoice.value == null) return const SizedBox.shrink();

      return Column(
        children: [
          // Primary share button
          GestureDetector(
            onTap: () => controller.shareInvoice(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Share Invoice',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Secondary actions row
          Row(
            children: [
              // Download PDF
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.downloadInvoice(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurfaceStroke.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.darkSurfaceStroke,
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf_outlined,
                          color: AppColors.textMutedDark,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Download PDF',
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
              ),
              const SizedBox(width: 12),

              // Copy Link
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.copyInvoiceLink(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurfaceStroke.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.darkSurfaceStroke,
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.link,
                          color: AppColors.textMutedDark,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Copy Link',
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
              ),
            ],
          ),
        ],
      );
    });
  }
}
