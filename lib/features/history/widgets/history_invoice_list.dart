import 'package:flutter/material.dart';
import 'package:morla/features/history/data/models/invoice_model.dart';
import '../../../core/widgets/invoice_card.dart';

class HistoryInvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  final String Function(double) formatCurrency;
  final String Function(DateTime) formatDate;
  final Function(Invoice) onInvoiceTap;
  final EdgeInsets? padding;
  final double spacing;

  const HistoryInvoiceList({
    super.key,
    required this.invoices,
    required this.formatCurrency,
    required this.formatDate,
    required this.onInvoiceTap,
    this.padding,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: padding ?? const EdgeInsets.only(bottom: 20),
      itemCount: invoices.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return InvoiceCard(
          invoice: invoice,
          formatCurrency: formatCurrency,
          formatDate: formatDate,
          onTap: () => onInvoiceTap(invoice),
        );
      },
    );
  }
}
