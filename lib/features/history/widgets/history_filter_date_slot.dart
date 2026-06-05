import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morla/core/theme/app_colors.dart';

class HistoryFilterDateSlot extends StatelessWidget {
  final String title;
  final String value;
  final bool active;

  const HistoryFilterDateSlot({
    super.key,
    required this.title,
    required this.value,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMutedDark,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : AppColors.textMutedDark,
            ),
          ),
        ],
      ),
    );
  }
}

String historyFilterDateText(DateTime date, {bool compact = false}) {
  const monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  if (compact) {
    return '${monthsShort[date.month - 1]} ${date.day}';
  }

  return '${monthsShort[date.month - 1]} ${date.day}, ${date.year}';
}
