import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool showChevron;


  const SettingsActionTile({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isDestructive = false,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          color: isDestructive ? AppColors.alertRed.withValues(alpha: 0.1) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isDestructive ? AppColors.alertRed : AppColors.primaryBlue,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                ],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDestructive ? title.toUpperCase() : title,
                      style: TextStyle(
                        fontFamily: isDestructive ? 'JetBrains Mono' : 'Plus Jakarta Sans',
                        fontSize: isDestructive ? 10 : 16,
                        fontWeight: isDestructive ? FontWeight.w700 : FontWeight.w400,
                        letterSpacing: isDestructive ? 2.0 : null,
                        color: isDestructive ? AppColors.alertRed : Colors.white,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontFamily: 'JetBrains Mono',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFBFC9C0),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFBFC9C0),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
