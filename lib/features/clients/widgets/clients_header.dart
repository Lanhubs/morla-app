import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morla/core/theme/app_colors.dart';

class ClientsHeader extends StatelessWidget {
  final String title;
  final String filterLabel;
  final VoidCallback? onFilterTap;

  const ClientsHeader({
    super.key,
    this.title = 'Client Directory',
    this.filterLabel = 'ALL ENTITIES',
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Filter Pill
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2024),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.filter_list,
                  color: AppColors.textMutedDark,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  filterLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMutedDark,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
