import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarFallback extends StatelessWidget {
  final String name;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  const AvatarFallback({
    super.key,
    required this.name,
    this.size = 48,
    this.backgroundColor = const Color(0xFF1E2024),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(name);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: size,
        height: size,
        color: backgroundColor,
        child: Center(
          child: Text(
            initials,
            style: GoogleFonts.plusJakartaSans(
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return '??';

    final parts = trimmedName.split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    return parts.take(2).map((e) => e[0]).join('').toUpperCase();
  }
}
