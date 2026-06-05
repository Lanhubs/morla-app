import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';

class HistoryLoadingState extends StatelessWidget {
  final Color? color;

  const HistoryLoadingState({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppColors.primaryBlue),
    );
  }
}
