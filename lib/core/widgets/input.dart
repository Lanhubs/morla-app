import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class Input extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final TextAlign? textAlign;

  final int? maxLines;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool showLabel;
  final Color? fillColor;
  final Color? borderColor;
  final ValueChanged<String>? onChanged;

  const Input({
    super.key,
    required this.hintText,
    required this.label,
    this.controller,
    this.obscureText,
    this.suffixText,
    this.prefixText,
    this.prefixStyle,
    this.suffixStyle,
    this.keyboardType,
    this.textAlign,
    this.maxLines = 1,
    this.validator,
    this.enabled = true,
    this.showLabel = true,
    this.fillColor,
    this.borderColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Text(
            label,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white,
                ) ??
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        if (showLabel) const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fillColor ?? const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(AppThemes.componentRadius),
            border: Border.all(color: borderColor?? Colors.transparent, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText ?? false,
                  keyboardType: keyboardType,
                  textAlign: textAlign ?? TextAlign.start,
                  maxLines: maxLines,
                  validator: validator,
                  enabled: enabled,
                  onChanged: onChanged,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixText: suffixText,
                    suffixStyle:
                        suffixStyle ??
                        GoogleFonts.jetBrainsMono(
                          color: AppColors.textMutedDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                    prefixText: prefixText,
                    prefixStyle:
                        prefixStyle ??
                        GoogleFonts.jetBrainsMono(
                          color: AppColors.textMutedDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                    hintText: hintText,
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: AppColors.inputPlaceholder,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
              if (obscureText == true)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMutedLight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
