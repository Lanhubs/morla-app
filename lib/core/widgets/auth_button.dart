import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: isOutlined
              ? Border.all(color: AppColors.lightSurface, width: 1.5)
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.lightSurface,
          ),
        ),
      ),
    );
  }
}
