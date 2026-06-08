import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_colors.dart';
import 'package:billkit/features/settlement_methods/controllers/settlement_methods_controller.dart';
import 'package:billkit/features/settlement_methods/view/widgets/fiat_account_card.dart';
import 'package:billkit/features/settlement_methods/view/widgets/crypto_wallet_card.dart';

class SettlementMethodsPage extends StatelessWidget {
  final SettlementMethodsController controller = Get.put(
    SettlementMethodsController(),
  );

  SettlementMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCanvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: const Text(
          'Infrastructure',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'GATEWAY CONFIGURATION & API MAPPING',
              style: TextStyle(
                color: Color(0xFF89938B),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchMethods,
          color: AppColors.primaryBlue,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _FiatRailMapping(controller: controller),
              const SizedBox(height: 24),
              _MultiChainWalletMapping(controller: controller),
              const SizedBox(height: 64),
            ],
          ),
        );
      }),
    );
  }
}

class _FiatRailMapping extends StatelessWidget {
  final SettlementMethodsController controller;

  const _FiatRailMapping({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'FIAT RAIL MAPPING',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(Icons.account_balance, color: Color(0xFF89938B), size: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controller.fiatMethods.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No fiat accounts mapped yet.',
                        style: TextStyle(
                          color: Color(0xFF89938B),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else
                  ...controller.fiatMethods.map(
                    (method) => FiatAccountCard(
                      method: method,
                      onTap: () => controller.editMethod(method),
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.syncGatewayConfig,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue.withValues(
                      alpha: 0.2,
                    ),
                    foregroundColor: AppColors.primaryBlue,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SYNC_GATEWAY_CONFIG',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiChainWalletMapping extends StatelessWidget {
  final SettlementMethodsController controller;

  const _MultiChainWalletMapping({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E293B),

        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'MULTI-CHAIN WALLET MAPPING',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(Icons.hub, color: Color(0xFF89938B), size: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: controller.cryptoMethods.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No wallets mapped yet.',
                        style: TextStyle(
                          color: Color(0xFF89938B),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: controller.cryptoMethods
                        .map(
                          (method) => CryptoWalletCard(
                            method: method,
                            onTap: () => controller.editMethod(method),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
