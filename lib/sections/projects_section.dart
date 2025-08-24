import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';
import '../data/projects.dart';
import '../widgets/appear_on_scroll.dart'; // ⬅️ yeni
import '../widgets/hover_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Responsive(
      builder: (context, width) {
        final isNarrow = width < 720;
        final cross = isNarrow ? 1 : 3;
        return Column(
          children: [
            // İstersen başlığı da animasyonla getir:
            AppearOnScroll(
              offsetY: 12,
              duration: const Duration(milliseconds: 420),
              child: Text(
                'Projeler',
                style: t.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cross,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isNarrow ? 16 / 9 : 4 / 3,
              ),
              itemCount: demoProjects.length,
              itemBuilder: (context, i) {
                final p = demoProjects[i];
                return AppearOnScroll(
                  key: ValueKey('project-$i'), // stabilize
                  offsetY: 20, // alttan gelsin
                  duration: Duration(
                    milliseconds: 420 + i * 60,
                  ), // hafif stagger
                  child: HoverCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          style: t.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(p.description, style: t.textTheme.bodyMedium),
                        const Spacer(),
                        Wrap(
                          spacing: 8,
                          runSpacing: -8,
                          children: p.tags
                              .map((e) => Chip(label: Text(e)))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (p.repoUrl != null)
                              TextButton(
                                onPressed: () => _open(p.repoUrl!),
                                child: const Text('Repo'),
                              ),
                            if (p.liveUrl != null)
                              TextButton(
                                onPressed: () => _open(p.liveUrl!),
                                child: const Text('Live'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
