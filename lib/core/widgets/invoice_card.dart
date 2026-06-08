import 'package:billkit/features/history/data/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';
class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback? onTap;
  final String Function(double) formatCurrency;
  final String Function(DateTime) formatDate;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.formatCurrency,
    required this.formatDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Invoice icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF334155).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedInvoice03,
                  color: AppColors.textMutedDark,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Invoice details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.clientName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${invoice.invoiceNumber} • ${formatDate(invoice.date)}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textMutedDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Amount and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCurrency(invoice.amount),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                StatusBadge(status: invoice.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case 'SENT':
        backgroundColor = const Color(0xFF8FD5AE).withValues(alpha: 0.15);
        textColor = const Color(0xFF8FD5AE);
        break;
      case 'PAID':
        backgroundColor = const Color(0xFF8FD5AE).withValues(alpha: 0.15);
        textColor = const Color(0xFF8FD5AE);
        break;
      case 'OVERDUE':
        backgroundColor = const Color(0xFFE05353).withValues(alpha: 0.15);
        textColor = const Color(0xFFE05353);
        break;
      case 'DRAFT':
        backgroundColor = const Color(0xFF94A3B8).withValues(alpha: 0.15);
        textColor = const Color(0xFF94A3B8);
        break;
      default:
        backgroundColor = const Color(0xFF94A3B8).withValues(alpha: 0.15);
        textColor = const Color(0xFF94A3B8);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}