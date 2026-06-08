import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';

class InvoiceDetailsHeader extends StatelessWidget {
  const InvoiceDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Get.back(),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Invoice ID and Badge
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'INVOICE ID',
                    style: TextStyle(
                      color: AppColors.textMutedDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.invoice.value!.invoiceNumber ?? controller.invoice.value!.id ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: _statusColor(controller.invoice.value!.status).withValues(alpha: 0.5),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  controller.invoice.value!.status?.toUpperCase() ?? 'DRAFT',
                  style: TextStyle(
                    color: _statusColor(controller.invoice.value!.status),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'PAID':
        return Colors.green;
      case 'SENT':
        return AppColors.primaryBlue;
      case 'OVERDUE':
        return AppColors.alertRed;
      case 'DRAFT':
      default:
        return AppColors.textMutedDark;
    }
  }
}
