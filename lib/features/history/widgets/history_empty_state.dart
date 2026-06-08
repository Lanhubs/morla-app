import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/theme/app_colors.dart';

class HistoryEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final double iconSize;

  const HistoryEmptyState({
    super.key,
    this.title = 'No invoices found',
    this.subtitle = 'Try adjusting your filters',
    this.icon = Icons.receipt_long_outlined,
    this.iconSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/empty-invoices.png",
            width: 80,
            height: 80,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textMutedDark,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: AppColors.textMutedDark.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
