import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const HistoryTitle({
    super.key,
    this.title = 'History',
    this.fontSize = 32,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
