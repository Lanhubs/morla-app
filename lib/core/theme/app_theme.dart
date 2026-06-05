import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Typography Constants

  // Shared Geometry Constants
  static const double componentRadius = 10.0;
  static const double sheetRadius = 16.0;

  // --- DARK THEME CONFIGURATION ---
  static final ThemeData darkTheme = ThemeData(
    
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkCanvas,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,

    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkSurface,
      onSurface: Colors.white,
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.darkCanvas,
      secondary: AppColors.jadeGreen,
      error: AppColors.alertRed,
    ),

    // Card/Container Geometry
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(componentRadius),
        side: const BorderSide(color: AppColors.darkSurfaceStroke, width: 1),
      ),
    ),

    // Input/Form Styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCanvas,
      hintStyle: const TextStyle(color: AppColors.inputPlaceholder),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.darkSurfaceStroke),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.darkSurfaceStroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
      ),
    ),

    // Button Geometry
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.darkCanvas,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: .circular(componentRadius)),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // Bottom Sheet Settings
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      showDragHandle: true,
      dragHandleColor: AppColors.textMutedDark,
      
    ),
  );

  // --- LIGHT THEME CONFIGURATION ---
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightCanvas,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,

    colorScheme: const ColorScheme.light(
      surface: AppColors.lightSurface,
      onSurface: AppColors.darkCanvas,
      primary: AppColors.primaryBlue,
      onPrimary: Colors.white,
      secondary: AppColors.mintGreen,
      error: AppColors.alertRed,
    ),
  
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(componentRadius),
        side: const BorderSide(color: AppColors.lightSurfaceStroke, width: 1),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightCanvas,
      hintStyle: const TextStyle(color: AppColors.inputPlaceholder),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.lightSurfaceStroke),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.lightSurfaceStroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(componentRadius),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: .circular(componentRadius)),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightSurface,
      elevation: 0,
      showDragHandle: true,
      dragHandleColor: AppColors.textMutedLight,
      shape: RoundedRectangleBorder(
        borderRadius: .vertical(top: Radius.circular(sheetRadius)),
        side: BorderSide(color: AppColors.lightSurfaceStroke, width: 0),

      ),
    ),
  );
}
