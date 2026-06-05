import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morla/core/theme/app_colors.dart';

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
    final bgColor = backgroundColor ?? Colors.white.withValues(alpha:0.03);
    final brdColor = borderColor ?? Colors.white.withValues(alpha:0.05);

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
          child: Center(child: _buildIcon(iconClr)),
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    if (icon is IconData) {
      return Icon(icon as IconData, color: color, size: 16);
    } else if (icon is List<List<dynamic>>) {
      return HugeIcon(
        icon: icon as List<List<dynamic>>,
        color: color,
        size: 16,
      );
    } else {
      return Icon(Icons.error, color: color, size: 16);
    }
  }
}
