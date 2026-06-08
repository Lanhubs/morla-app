import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/controllers/current_user_controller.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/settings/controllers/settings_controller.dart';
import '../widgets/index.dart';
import 'package:billkit/routes/app_routes.dart';

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
                      child: Obx(() {
                        if (controller.isLoadingPayouts.value) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        return Column(
                          children: [
                            ...controller.payoutMethods.map((method) {
                              String subtitle = '';
                              IconData icon = Icons.payment;

                              if (method.methodType == 'crypto') {
                                icon = Icons.account_balance_wallet;
                                final addr = method.walletAddress ?? '';
                                subtitle = addr.length > 10
                                    ? '${addr.substring(0, 6)}...${addr.substring(addr.length - 4)}'
                                    : addr;
                              } else if (method.methodType == 'bank') {
                                icon = Icons.account_balance;
                                final accNum = method.accountNumber ?? '';
                                subtitle = '${method.bankName ?? 'Bank'} •••${accNum.length >= 4 ? accNum.substring(accNum.length - 4) : accNum}';
                              }

                              if (method.isDefault) {
                                subtitle += ' (Default)';
                              }

                              return SettingsActionTile(
                                icon: icon,
                                title: method.label,
                                subtitle: subtitle,
                                showChevron: true,
                                onTap: () => Get.toNamed(AppRoutes.settlementMethods),
                              );
                            }),
                            PaymentChannelBtn(
                              onTap: () => Get.toNamed(AppRoutes.paymentSetup),
                            ),
                          ],
                        );
                      }),
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
