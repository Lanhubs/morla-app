import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';

class ClientsLoadingState extends StatelessWidget {
  final Color? color;

  const ClientsLoadingState({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppColors.mintGreen),
    );
  }
}
