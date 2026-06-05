import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';

class SettingsToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onChanged;

  const SettingsToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: value ? AppColors.primaryBlue : Colors.white.withValues(alpha: 0.1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value ? 22 : 2,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkCanvas,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
