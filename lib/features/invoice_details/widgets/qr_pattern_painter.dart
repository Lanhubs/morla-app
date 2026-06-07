import 'package:flutter/material.dart';

class QrPatternPainter extends CustomPainter {
  final int seed;
  QrPatternPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    const gridSize = 21;
    final cellSize = size.width / gridSize;

    // Draw border
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        // Corner finder patterns (7x7 squares in 3 corners)
        if (_isFinderPattern(i, j, gridSize)) {
          canvas.drawRect(
            Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
            paint,
          );
          continue;
        }

        // Pseudo-random data modules
        final val = (seed + i * 37 + j * 13) % 3;
        if (val == 0) {
          canvas.drawRect(
            Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }
  }

  bool _isFinderPattern(int row, int col, int size) {
    // Top-left
    if (row < 7 && col < 7) {
      if (row == 0 || row == 6 || col == 0 || col == 6) return true;
      if (row >= 2 && row <= 4 && col >= 2 && col <= 4) return true;
      return false;
    }
    // Top-right
    if (row < 7 && col >= size - 7) {
      final c = col - (size - 7);
      if (row == 0 || row == 6 || c == 0 || c == 6) return true;
      if (row >= 2 && row <= 4 && c >= 2 && c <= 4) return true;
      return false;
    }
    // Bottom-left
    if (row >= size - 7 && col < 7) {
      final r = row - (size - 7);
      if (r == 0 || r == 6 || col == 0 || col == 6) return true;
      if (r >= 2 && r <= 4 && col >= 2 && col <= 4) return true;
      return false;
    }
    return false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
