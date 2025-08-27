import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_site/pages/blog/blog_page.dart';
import 'package:portfolio_site/pages/blog/post_page.dart';
import 'package:portfolio_site/pages/components/components_page.dart';
import 'package:portfolio_site/sections/home_page.dart';

// sayfa geçişi için blurlu animasyon
CustomTransitionPage<void> _fadeBlurPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 700),
    transitionsBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: AnimatedBuilder(
          animation: curved,
          builder: (context, _) {
            final sigma = (1 - curved.value) * 12;
            return ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: child,
            );
          },
        ),
      );
    },
  );
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/blog',
        pageBuilder: (context, state) => _fadeBlurPage(const ComingSoonPage()),
      ),
      GoRoute(
        path: '/blog/:slug',
        pageBuilder: (context, state) {
          final slug = state.pathParameters['slug']!;
          return _fadeBlurPage(PostPage(slug: slug));
        },
      ),
      GoRoute(
        path: '/components',
        pageBuilder: (context, state) => _fadeBlurPage(const ComponentsPage()),
      ),
    ],
  );
}
