import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/core/theme/app_colors.dart';
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final List<List<dynamic>> icon;
  final bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HugeIcon(icon:icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}