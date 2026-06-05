import 'package:flutter/material.dart';
import 'package:morla/core/theme/app_colors.dart';
import 'grid_mesh_painter.dart';

class ClientsBackground extends StatelessWidget {
  final Color canvasColor;
  final Color gradientColor;
  final double gradientRadius;
  final double gradientOpacity;

  const ClientsBackground({
    super.key,
    this.canvasColor = AppColors.darkCanvas,
    this.gradientColor = const Color(0xFF3B7A57),
    this.gradientRadius = 1.2,
    this.gradientOpacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Solid background
        Positioned.fill(
          child: Container(decoration: BoxDecoration(color: canvasColor)),
        ),
        // Radial gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: gradientRadius,
                colors: [
                  gradientColor.withValues(alpha: gradientOpacity),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Grid mesh overlay
        const Positioned.fill(child: CustomPaint(painter: GridMeshPainter())),
      ],
    );
  }
}
