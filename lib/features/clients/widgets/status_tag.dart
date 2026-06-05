import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusTag extends StatelessWidget {
  final String status;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const StatusTag({
    super.key,
    required this.status,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  factory StatusTag.settled() {
    return StatusTag(
      status: 'SETTLED',
      backgroundColor: const Color(0xFFA2E9C1).withValues(alpha:0.1),
      borderColor: const Color(0xFFA2E9C1).withValues(alpha:0.2),
      textColor: const Color(0xFF8FD5AE),
    );
  }

  factory StatusTag.pending() {
    return StatusTag(
      status: 'PENDING',
      backgroundColor: const Color(0xFF0F5434).withValues(alpha:0.2),
      borderColor: const Color(0xFF0F5434).withValues(alpha:0.3),
      textColor: const Color(0xFF93D5AC),
    );
  }

  factory StatusTag.overdue() {
    return StatusTag(
      status: 'OVERDUE',
      backgroundColor: const Color(0xFFE05353).withValues(alpha:0.1),
      borderColor: const Color(0xFFE05353).withValues(alpha:0.2),
      textColor: const Color(0xFFE05353),
    );
  }

  factory StatusTag.fromStatus(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'settled') return StatusTag.settled();
    if (lowerStatus == 'pending') return StatusTag.pending();
    if (lowerStatus == 'overdue') return StatusTag.overdue();

    // Default to pending for unknown statuses
    return StatusTag.pending();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? const Color(0xFF0F5434).withValues(alpha:0.2);
    final brdColor = borderColor ?? const Color(0xFF0F5434).withValues(alpha:0.3);
    final txtColor = textColor ?? const Color(0xFF93D5AC);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: brdColor),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: txtColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
