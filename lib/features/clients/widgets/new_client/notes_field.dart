import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:billkit/core/theme/app_theme.dart';
import 'package:billkit/core/theme/app_colors.dart';
class NotesField extends StatelessWidget {
  final  String label;
  final  TextEditingController controller;
  const NotesField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ) ??
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(AppThemes.componentRadius),
            border: Border.all(color: Colors.transparent, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter any additional notes',
                    hintStyle:
                        Theme.of(context).inputDecorationTheme.hintStyle ??
                        TextStyle(color: AppColors.textMutedLight),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedEdit01,
                    size: 20,
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}