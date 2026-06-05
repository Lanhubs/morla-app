import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/controllers/current_user_controller.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'package:morla/features/settings/controllers/settings_controller.dart';
import '../widgets/index.dart';
import 'package:morla/routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is registered
    final controller = Get.put(SettingsController());
    final currentUserController = Get.find<CurrentUserController>();

    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      body: Obx(
        () => SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SettingsHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 24,
                    bottom: 120,
                  ),
                  children: [
                    const SettingsProfileCard(),
                    const SizedBox(height: 24),

                    // SECURITY & ACCESS
                    const SettingsSectionHeader(title: 'SECURITY & ACCESS'),
                    SettingsGlassPanel(
                      child: Column(
                        children: [
                          SettingsToggleTile(
                            icon: Icons.fingerprint,
                            title: 'Biometric Auth',
                            value: controller.biometricAuth.value,
                            onChanged: controller.toggleBiometricAuth,
                          ),
                          SettingsToggleTile(
                            icon: Icons.key,
                            title: '2FA Key Sync',
                            value: controller.keySync.value,
                            onChanged: controller.toggleKeySync,
                          ),
                          const SettingsValueTile(
                            icon: Icons.timer,
                            title: 'Session Timeout',
                            value: '15m',
                            isHighlighted: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PAYOUT CHANNELS
                    const SettingsSectionHeader(title: 'PAYOUT CHANNELS'),
                    SettingsGlassPanel(
                      child: Column(
                        children: [
                          SettingsActionTile(
                            icon: Icons.account_balance_wallet,
                            title: 'Primary Wallet',
                            subtitle: '0x71C...8e42',
                            showChevron: true,
                            onTap: () {},
                          ),
                          SettingsActionTile(
                            icon: Icons.account_balance,
                            title: 'Bank Rails',
                            subtitle: 'Active',
                            showChevron: true,
                            onTap: () {},
                          ),
                          PaymentChannelBtn(
                            onTap: () => Get.toNamed(AppRoutes.paymentSetup),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // WORKSPACE
                    const SettingsSectionHeader(title: 'WORKSPACE'),
                    SettingsGlassPanel(
                      child: Column(
                        children: [
                          SettingsToggleTile(
                            title: 'Grid Mesh Overlay',
                            value: controller.gridMeshOverlay.value,
                            onChanged: controller.toggleGridMesh,
                          ),
                          SettingsToggleTile(
                            title: 'High-Contrast Mode',
                            value: controller.highContrastMode.value,
                            onChanged: controller.toggleHighContrast,
                          ),
                          SettingsToggleTile(
                            title: 'Real-time Telemetry',
                            value: controller.telemetry.value,
                            onChanged: controller.toggleTelemetry,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PREFERENCES
                    const SettingsSectionHeader(title: 'PREFERENCES'),
                    SettingsGlassPanel(
                      child: Column(
                        children: [
                          SettingsValueTile(
                            title: 'Language',
                            value: 'English',
                          ),
                          SettingsValueTile(
                            title: 'Currency',
                            value: 'USD / USDC',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // SUPPORT SECTION
                    SettingsGlassPanel(
                      child: Column(
                        children: [
                          SettingsActionTile(
                            icon: Icons.description,
                            title: 'View Documentation',
                            onTap: () {},
                          ),
                          const SettingsValueTile(
                            icon: Icons.cloud_done,
                            title: 'System Status',
                            value: 'NOMINAL',
                            isHighlighted: true,
                          ),
                          SettingsActionTile(
                            icon: Icons.logout,
                            title: 'Sign Out',
                            isDestructive: true,
                            onTap: () =>
                                LogoutBottomSheet.show(context, () async {
                                  await currentUserController.clearSession();
                                  Get.offAllNamed(AppRoutes.onboarding);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
