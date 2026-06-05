import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morla/core/theme/app_colors.dart';

class FilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool highlighted;

  const FilterDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.backgroundColor,
    this.borderColor,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdownMenu(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              const Color(
                0xFF1E293B,
              ).withValues(alpha: highlighted ? 0.5 : 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                borderColor ??
                (highlighted
                    ? AppColors.primaryBlue.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1)),
            width: highlighted ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: highlighted ? AppColors.primaryBlue : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: highlighted
                  ? AppColors.primaryBlue
                  : AppColors.textMutedDark,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...items.map((item) {
              final isSelected = item == value;
              final accent = item == 'PAID'
                  ? AppColors.mintGreen
                  : item == 'OVERDUE'
                  ? AppColors.alertRed
                  : item == 'SENT'
                  ? AppColors.primaryBlue
                  : AppColors.textMutedDark;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    onChanged(item);
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryBlue.withValues(alpha: 0.14)
                          : Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryBlue.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.92),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primaryBlue,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
