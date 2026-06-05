import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';

class VerificationSection extends StatelessWidget {
  const VerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'EXTERNAL VERIFICATION',
                style: TextStyle(
                  color: Color(0xFF89938B),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Paid externally? Paste block transaction hash (Tx Hash) here to force verify',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF89938B), fontSize: 12),
        ),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: AppColors.primaryBlue),
          decoration: InputDecoration(
            hintText: '0x... or transaction identifier',
            hintStyle: TextStyle(
              color: const Color(0xFF89938B).withValues(alpha: 0.4),
            ),
            filled: true,
            fillColor: AppColors.darkSurface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primaryBlue.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
