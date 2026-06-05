import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/settings/widgets/settings_glass_panel.dart';
import 'package:morla/routes/app_routes.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserController = Get.find<CurrentUserController>();

    return Obx(() {
      final currentUser = currentUserController.user.value;
      final displayName = _displayName(
        currentUser?.fullName,
        currentUser?.email,
      );
      final planTier = _planTierLabel(currentUser?.planTier);

      return SettingsGlassPanel(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuC4smRIAjMd9jqGABNz3J5VoM4eeBWWQYf8w147ekiCKiyPglq9JzOGgG2TUe1w4UjiQuDfIAYdjSDKO036MxeWXd9VUQuSPtsibRY3U6j4tXLuDK_tqjpy4CcU2Py9F5mWf_yVaVT-_UuXt4kOREMpYvp2JsRJ_FNgneWFmrYuWcgu1SefPfNGvL-2CF6ooYT_4LH6FNw_VJN_r-joDEPCe8cqhoRpYnAiDk50Df50ZwI_1yAVq9yM--UkwhDi8WomC_A853zxVbA',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.darkCanvas,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.primaryBlue.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          planTier,
                          style: const TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () =>Get.toNamed(AppRoutes.profileEdit),
                icon: const Icon(Icons.edit_note, color: AppColors.primaryBlue),
              ),
            ],
          ),
          
        ),
      );
    });
  }

  String _displayName(String? fullName, String? email) {
    if (fullName != null && fullName.trim().isNotEmpty) {
      return fullName.trim().toUpperCase();
    }

    if (email != null && email.trim().isNotEmpty) {
      final local = email.split('@').first.trim();
      if (local.isNotEmpty) {
        return local.toUpperCase();
      }
    }

    return 'OPERATOR_01';
  }

  String _planTierLabel(String? planTier) {
    if (planTier == null || planTier.trim().isEmpty) {
      return 'FREE_TIER';
    }

    return '${planTier.trim().toUpperCase()}_TIER';
  }
}
