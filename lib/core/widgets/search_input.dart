import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/theme/app_colors.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Color? borderColor;

  const SearchInput({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? const Color(0xFF1E293B).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          filled: false,
          hintStyle: GoogleFonts.plusJakartaSans(
            color: AppColors.textMutedDark,
            fontSize: 15,
          ),
          prefixIcon:
              prefixIcon ??
              Icon(Icons.search, color: AppColors.textMutedDark, size: 22),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
