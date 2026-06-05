import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/invoice_details/controllers/invoice_details_controller.dart';
import 'package:morla/features/invoice_details/widgets/service_item_row.dart';

class ServiceItemizationSection extends StatelessWidget {
  const ServiceItemizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Obx(() {
      if (controller.invoice.value == null) return const SizedBox.shrink();
      final invoice = controller.invoice.value!;
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF1E293B), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Text(
                'Service Itemization',
                style: TextStyle(
                  color: AppColors.textMutedDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Dynamic item rows from controller
            ...invoice.items.map((item) => ServiceItemRow(
              title: item.description,
              subtitle: 'Qty: ${item.quantity} / Unit: \$${item.price.toStringAsFixed(2)}',
              amount: '\$${item.total.toStringAsFixed(2)}',
            )),

            // Total Amount Block
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '\$${invoice.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
