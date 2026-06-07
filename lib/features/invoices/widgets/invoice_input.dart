import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morla/core/theme/app_colors.dart';

class InvoiceInput extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool? enabled;
  final Color? fillColor;

  const InvoiceInput({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isRequired = false,
    this.keyboardType,
    this.prefixText,
    this.suffixText,
    this.prefixStyle,
    this.suffixStyle,
    this.textAlign,
    this.maxLines = 1,
    this.validator,
    this.enabled = true,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text(
                '*',
                style: TextStyle(
                  color: AppColors.alertRed,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines,
          validator: validator,
          enabled: enabled,
          style: maxLines == 1
              ? GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )
              : GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: AppColors.inputPlaceholder,
              fontSize: 14,
            ),
            prefixText: prefixText,
            prefixStyle:
                prefixStyle ??
                GoogleFonts.jetBrainsMono(
                  color: AppColors.textMutedDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
            suffixText: suffixText,
            suffixStyle:
                suffixStyle ??
                GoogleFonts.jetBrainsMono(
                  color: AppColors.textMutedDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
            filled: true,
            fillColor:
                fillColor ?? const Color(0xFF1E293B).withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.alertRed, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.alertRed, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
