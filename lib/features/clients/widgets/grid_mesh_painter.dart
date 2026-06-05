import 'package:flutter/material.dart';

/// Custom painter for grid mesh background
class GridMeshPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double step;

  const GridMeshPainter({
    this.color = Colors.white,
    this.strokeWidth = 1.0,
    this.step = 24.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha:0.015)
      ..strokeWidth = strokeWidth;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
