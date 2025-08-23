import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  /// Dark-first: night/charcoal zemin, ecru CTA
  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.ecru, // CTA / aksan
      onPrimary: Colors.black, // ecru üzerinde siyah okunur
      secondary: AppColors.slateBlue, // ikincil vurgu
      onSecondary: Colors.white,
      surface: AppColors.gunmetal, // kart/section zemini
      onSurface: AppColors.textLight,
      error: Color(0xFFEF4444),
      onError: Colors.black,
    );

    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.night,
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textLight,
        displayColor: AppColors.textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textLight,
          side: const BorderSide(color: AppColors.slateBlue),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.gunmetal,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),

      dividerColor: AppColors.steel.withOpacity(.5),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.steel,
        side: BorderSide(color: AppColors.steel.withOpacity(.6)),
        labelStyle: const TextStyle(color: AppColors.textLight),
      ),
    );
  }

  /// İstersen açık tema da tutalım (opsiyonel)
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.ecru,
      brightness: Brightness.light,
    );
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: scheme,
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
    );
  }
}
