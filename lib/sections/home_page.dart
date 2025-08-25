import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_site/sections/skills_grid_section.dart';
import 'package:provider/provider.dart';

import '../core/responsive.dart';
import '../core/section_keys.dart';
import '../theme/theme_controller.dart';
import 'about_section.dart';
import 'contact_section.dart';
import 'footer.dart';
import 'hero_section.dart';
import 'projects_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final keys = SectionKeys();
  final controller = ScrollController();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      alignment: 0.08,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _TopNav(
        onHero: () => _scrollTo(keys.heroKey),
        onProjects: () => _scrollTo(keys.projectsKey),
        onAbout: () => _scrollTo(keys.aboutKey),
        onContact: () => _scrollTo(keys.contactKey),
      ),
      body: Scrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              KeyedSubtree(key: keys.heroKey, child: const HeroSection()),
              const SizedBox(height: 32),
              Responsive(builder: (context, _) => const Divider(height: 1)),
              const SizedBox(height: 32),
              const SkillsGridSection(
                skills: [
                  'Flutter',
                  'Dart',
                  'Swift',
                  'SwiftUI',
                  'Firebase',
                  'Node.js',
                  'PostgreSQL',
                  'MongoDB',
                  'AI/ML',
                  'REST',
                  'GraphQL',
                  'FastAPI',
                ],
              ),
              const SizedBox(height: 32),
              Responsive(builder: (context, _) => const Divider(height: 1)),
              const SizedBox(height: 50),
              KeyedSubtree(
                key: keys.projectsKey,
                child: const ProjectsSection(),
              ),
              const SizedBox(height: 32),
              Responsive(builder: (context, _) => const Divider(height: 1)),
              const SizedBox(height: 32),
              KeyedSubtree(key: keys.aboutKey, child: const AboutSection()),
              const SizedBox(height: 32),
              KeyedSubtree(key: keys.contactKey, child: const ContactSection()),
              const SizedBox(height: 40),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopNav extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHero, onProjects, onAbout, onContact;
  const _TopNav({
    required this.onHero,
    required this.onProjects,
    required this.onAbout,
    required this.onContact,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return AppBar(
      title: Text(
        'OmerFarukYilmaz.dev',
        style: (t.textTheme.titleLarge ?? TextStyle(fontSize: 20)).copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        TextButton(onPressed: onHero, child: const Text('Anasayfa')),
        TextButton(onPressed: onProjects, child: const Text('Projeler')),
        TextButton(onPressed: onAbout, child: const Text('Hakkımda')),
        TextButton(onPressed: onContact, child: const Text('İletişim')),
        IconButton(
          tooltip: 'Theme',
          onPressed: () => context.read<ThemeController>().toggle(),
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.wb_sunny
                : Icons.dark_mode,
          ),
        ),
        const SizedBox(width: 12),
        FilledButton.tonal(
          onPressed: () => context.go('/blog'),
          child: const Text('Blog'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () => context.go('/components'),
          child: const Text('Components'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
