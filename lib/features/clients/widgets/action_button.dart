import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_colors.dart';

class ActionButton extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 36,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconClr = iconColor ?? AppColors.textMutedDark;
    final bgColor = backgroundColor ?? Colors.white.withValues(alpha: 0.03);
    final brdColor = borderColor ?? Colors.white.withValues(alpha: 0.05);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: brdColor),
          ),
          child: icon is IconData
              ? Icon(icon as IconData, color: iconClr, size: 16)
              : icon is List<List<dynamic>>
              ? HugeIcon(
                  icon: icon as List<List<dynamic>>,
                  color: iconClr,
                  size: 16,
                )
              : Icon(Icons.error, color: iconClr, size: 16),
        ),
      ),
    );
  }
}
