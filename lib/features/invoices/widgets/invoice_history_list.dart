import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/invoices/controllers/invoices_controller.dart';
import 'package:morla/features/invoices/data/models/invoice_model.dart';
import 'package:morla/features/invoices/widgets/invoice_history_card.dart';

class InvoiceHistoryList extends GetView<InvoicesController> {
  const InvoiceHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isFetchingInvoices) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        );
      }

      final invoices = controller.fetchedInvoices;

      if (invoices.isEmpty) {
        return const Center(
          child: Text(
            'No invoices yet. Create one to get started!',
            style: TextStyle(color: AppColors.textMutedDark),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: invoices
            .map((invoice) => InvoiceHistoryCard(invoice: invoice))
            .toList(),
      );
    });
  }
}
