import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

enum TitleType { h1, h2, h3, h4, h5, h6 }

enum TitleColor { primary, secondary, light, dark }

class AuthTitle extends StatelessWidget {
  final String title;
  final TitleType type;
  final TitleColor color;

  const AuthTitle({
    super.key,
    required this.title,
    this.type = TitleType.h1,
    this.color = TitleColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        /*  type == TitleType.h1
            ? 24
            : type == TitleType.h2
            ? 20
            : type == TitleType.h3
            ? 18
            : type == TitleType.h4
            ? 16
            : type == TitleType.h5
            ? 14
            : 12, */
        fontWeight: FontWeight.normal,
        color: color == TitleColor.primary
            ? Theme.of(context).primaryColor
            : color == TitleColor.secondary
            ? Theme.of(context).colorScheme.secondary
            : color == TitleColor.light
            ? Colors.white
            : Theme.of(context).colorScheme.onSurface,
        fontFamily: GoogleFonts.questrial().fontFamily,
      ),
    );
  }
}
