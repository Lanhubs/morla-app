import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBrX7RKCUKGTlvAd4E46eDaKR4APOtvcujxX9_rRwwVNKbQBN6I6ASYTtDBc7B5QNlXK-yy5ONd6sLgcdYFTFHAMLMRY91lY2kWLDu-x1CJ-gw1FdhIkTnwsBMScmxMVlSEG-p267VNMg76eFQzOFZcgpTJVOI-ecjKEJewLnCXNzOr9l46o04Sl7CW8opvfXdWzjYl0Yo02c3MxJW3WcOUDtovAcGabc5MFdUW2guaU-ZR0i_6vM8l_5tW-0TyhvAGiIewl2sTBSg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'MORLA',
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.monitor_outlined,
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}
