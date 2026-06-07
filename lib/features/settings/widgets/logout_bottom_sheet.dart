import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/core/widgets/cta_button.dart';
import 'package:get/get.dart';

class LogoutBottomSheet extends StatelessWidget {
  final VoidCallback onConfirmLogout;

  const LogoutBottomSheet({super.key, required this.onConfirmLogout});

  static void show(BuildContext context, VoidCallback onConfirmLogout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => LogoutBottomSheet(onConfirmLogout: onConfirmLogout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0F1419),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.alertRed.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.logout_rounded,
              color: AppColors.alertRed,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            'Log Out',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            'Are you sure you want to log out? You will need to sign in again to access your account.',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMutedDark),
          ),
          const SizedBox(height: 32),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CtaButton(
                  text: 'Cancel',
                  onPressed: () => Get.back(),
                  type: CtaButtonType.outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: CtaButton(
                  text: 'Log Out',
                  onPressed: () {
                    Get.back();
                    onConfirmLogout();
                  },
                  type: CtaButtonType.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
