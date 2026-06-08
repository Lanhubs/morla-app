import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';  
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.darkSurfaceStroke, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.textMutedDark,
              fontSize: 12,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.darkSurfaceStroke, thickness: 1),
        ),
      ],
    );
  }
}
