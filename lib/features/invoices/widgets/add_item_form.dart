import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/core/widgets/invoice_input.dart';
import 'package:billkit/features/invoices/controllers/invoices_controller.dart';

class AddItemForm extends StatelessWidget {
  final InvoicesController controller;

  const AddItemForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvoiceInput(
          label: 'Description',
          controller: controller.newDescriptionController,
          hintText: 'e.g., Web Design Services',
          isRequired: true,
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        QuantityAndPriceRow(controller: controller),
        const SizedBox(height: 20),
        TaxSection(controller: controller),
      ],
    );
  }
}

class QuantityAndPriceRow extends StatelessWidget {
  final InvoicesController controller;

  const QuantityAndPriceRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: QuantityField(controller: controller)),
        const SizedBox(width: 16),
        Expanded(flex: 3, child: PriceField(controller: controller)),
      ],
    );
  }
}

class QuantityField extends StatelessWidget {
  final InvoicesController controller;

  const QuantityField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InvoiceInput(
      label: 'Quantity',
      controller: controller.newQtyController,
      hintText: '1',
      isRequired: true,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final qty = int.tryParse(value);
        if (qty == null || qty <= 0) return 'Invalid';
        return null;
      },
    );
  }
}

class PriceField extends StatelessWidget {
  final InvoicesController controller;

  const PriceField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InvoiceInput(
      label: 'Price',
      controller: controller.newPriceController,
      hintText: '0.00',
      isRequired: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      prefixText: '\$ ',
      prefixStyle: GoogleFonts.jetBrainsMono(
        color: AppColors.mintGreen,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        final price = double.tryParse(value);
        if (price == null || price < 0) return 'Invalid';
        return null;
      },
    );
  }
}

class TaxSection extends StatelessWidget {
  final InvoicesController controller;

  const TaxSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InvoiceInput(
          label: 'Tax Rate',
          controller: controller.newTaxController,
          hintText: '5.0',
          isRequired: false,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          suffixText: '%',
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 14,
              color: AppColors.textMutedDark.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 6),
            Text(
              'Default: 5% sales tax',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textMutedDark.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
