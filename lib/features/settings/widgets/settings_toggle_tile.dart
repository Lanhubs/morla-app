import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/settings/widgets/settings_toggle_switch.dart';

class SettingsToggleTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool value;
  final VoidCallback onChanged;

  const SettingsToggleTile({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
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
          SettingsToggleSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
