import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  static const heroDark = LinearGradient(
    begin: Alignment(-1, -0.6),
    end: Alignment(1, 0.8),
    colors: [AppColors.night, AppColors.charcoal, AppColors.ecru],
    stops: [0.0, 0.58, 1.0],
  );

  static const heroLight = LinearGradient(
    begin: Alignment(-1, -0.6),
    end: Alignment(1, 0.8),
    colors: [Colors.white, AppColors.champagne, AppColors.ecru],
    stops: [0.0, 0.72, 1.0],
  );

  static const hero = heroDark;

  static LinearGradient heroFor(Brightness b) =>
      b == Brightness.dark ? heroDark : heroLight;

  static const cta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.champagne, AppColors.ecru, AppColors.brass],
  );

  static const cool = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.charcoal, AppColors.slateBlue],
  );
}
