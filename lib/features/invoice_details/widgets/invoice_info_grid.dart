import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/invoice_details/controllers/invoice_details_controller.dart';
import 'package:billkit/features/invoice_details/widgets/info_card.dart';

class InvoiceInfoGrid extends StatelessWidget {
  const InvoiceInfoGrid({super.key});

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceDetailsController>();
    return Obx(() {
      final invoice = controller.invoice.value!;
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  label: 'Client',
                  value: invoice.clientName,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InfoCard(
                  label: 'Timestamp',
                  value: _formatDate(invoice.invoiceDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  label: 'Due Threshold',
                  value: _formatDate(invoice.dueDate),
                  valueColor: invoice.status == 'OVERDUE' ? AppColors.alertRed : Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InfoCard(
                  label: 'Settlement',
                  value: invoice.settlementAsset ?? invoice.settlementMethod ?? 'TBD',
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
