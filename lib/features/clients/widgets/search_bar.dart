import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:billkit/core/theme/app_colors.dart';

class ClientsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onAddClient;

  const ClientsSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search clients...',
    this.onChanged,
    this.onAddClient,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: controller,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: AppColors.textMutedDark,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textMutedDark,
                  size: 20,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        if (onAddClient != null) ...[
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onAddClient,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.lightSurface,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              '+ Add Client',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.lightCanvas,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
