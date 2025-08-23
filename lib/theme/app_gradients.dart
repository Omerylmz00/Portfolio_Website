import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  // Hero: night -> charcoal -> ecru (ecru az miktar)
  static const hero = LinearGradient(
    begin: Alignment(-1, -0.6),
    end: Alignment(1, 0.8),
    colors: [AppColors.night, AppColors.charcoal, AppColors.ecru],
    stops: [0.0, 0.58, 1.0],
  );

  // CTA: ecru metalik şerit
  static const cta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.champagne, AppColors.ecru, AppColors.brass],
  );

  // Link/ikon arkaplanı
  static const cool = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.charcoal, AppColors.slateBlue],
  );
}
