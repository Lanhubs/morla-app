import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';

class SettingsValueTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String value;
  final bool isHighlighted;

  const SettingsValueTile({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: AppColors.primaryBlue, size: 24),
                const SizedBox(width: 16),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: isHighlighted ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : null,
            decoration: isHighlighted
                ? BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isHighlighted ? AppColors.primaryBlue : const Color(0xFFBFC9C0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
