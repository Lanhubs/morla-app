import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:morla/features/new_invoice/controllers/new_invoice_controller.dart';
import 'package:morla/features/invoices/widgets/billed_to_section.dart';
import 'package:morla/features/invoices/widgets/currency_section.dart';
import 'package:morla/features/invoices/widgets/index.dart';
import 'package:morla/features/invoices/widgets/invoice_header_row.dart';
import 'package:morla/features/invoices/widgets/invoice_memo_section.dart';
import 'package:morla/features/invoices/widgets/invoice_totals_card.dart';
import 'package:morla/features/invoices/widgets/save_template_toggle.dart';

class NewInvoiceForm extends StatelessWidget {
  final NewInvoiceController controller;
  const NewInvoiceForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Invoice number + date row
          InvoiceHeaderRow(controller: controller),
          const SizedBox(height: 16),

          // Billed To
          BilledToSection(controller: controller),
          const SizedBox(height: 20),

          // Currency
          CurrencySection(controller: controller),
          const SizedBox(height: 20),

          // Item Details (table with items)
          ItemDetailsSection(controller: controller),
          const SizedBox(height: 20),

          // Save as Client Template toggle
          SaveTemplateToggle(controller: controller),
          const SizedBox(height: 20),

          // Totals card (subtotal, tax, grand total)
          InvoiceTotalsCard(controller: controller),
          const SizedBox(height: 24),

          // Invoice memo
          InvoiceMemoSection(controller: controller),
          const SizedBox(height: 20),

          // Save button
          Center(
            child: Obx(
              () => CtaButton(
                text: controller.isCreating ? 'Saving...' : 'Save Invoice',
                onPressed: controller.isCreating
                    ? null
                    : () => controller.saveInvoice(),
                type: CtaButtonType.primary,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
