// lib/main.dart
import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/theme_controller.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController()..load(),
      child: const PortfolioApp(),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();
    final themeMode = context.watch<ThemeController>().mode;
    return MaterialApp.router(
      title: 'Ömer Faruk Yılmaz - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      themeAnimationDuration: const Duration(milliseconds: 100),
      themeAnimationCurve: Curves.easeInOut,
      routerConfig: router,
    );
  }
}
