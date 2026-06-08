import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/new_invoice/data/models/new_invoice_model.dart';
import 'package:billkit/routes/app_routes.dart';

class InvoiceHistoryCard extends StatelessWidget {
  final NewInvoiceModel invoice;

  const InvoiceHistoryCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceStroke.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.darkSurfaceStroke, width: 1),
        ),
        child: Row(
          children: [
            // Left: Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Middle: ID and Client
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.invoiceNumber ?? invoice.id ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    invoice.clientName,
                    style: const TextStyle(
                      color: AppColors.textMutedDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_monthName(invoice.invoiceDate.month)} ${invoice.invoiceDate.day.toString().padLeft(2, '0')}, ${invoice.invoiceDate.year}',
                    style: const TextStyle(
                      color: AppColors.textMutedDark,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Right: Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${invoice.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: invoice.status == 'OVERDUE'
                        ? AppColors.alertRed.withValues(alpha: 0.12)
                        : Colors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: invoice.status == 'OVERDUE'
                          ? AppColors.alertRed.withValues(alpha: 0.4)
                          : Colors.green.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    invoice.status ?? 'PAID',
                    style: TextStyle(
                      color: invoice.status == 'OVERDUE'
                          ? AppColors.alertRed
                          : Colors.green,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textMutedDark,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }
}
