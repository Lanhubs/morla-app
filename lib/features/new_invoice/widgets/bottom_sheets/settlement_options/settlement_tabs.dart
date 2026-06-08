import 'package:flutter/material.dart';
import 'package:billkit/core/theme/app_colors.dart';

class SettlementTabs extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChanged;

  const SettlementTabs({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('crypto'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: activeTab == 'crypto'
                      ? AppColors.primaryBlue.withValues(alpha: 0.1)
                      : Colors.transparent,
                  border: Border.all(
                    color: activeTab == 'crypto'
                        ? AppColors.primaryBlue.withValues(alpha: 0.2)
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'CRYPTO ASSETS',
                  style: TextStyle(
                    color: activeTab == 'crypto'
                        ? AppColors.primaryBlue
                        : const Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('fiat'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: activeTab == 'fiat'
                      ? AppColors.primaryBlue.withValues(alpha: 0.1)
                      : Colors.transparent,
                  border: Border.all(
                    color: activeTab == 'fiat'
                        ? AppColors.primaryBlue.withValues(alpha: 0.2)
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'FIAT CHECKOUT',
                  style: TextStyle(
                    color: activeTab == 'fiat'
                        ? AppColors.primaryBlue
                        : const Color(0xFF89938B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
