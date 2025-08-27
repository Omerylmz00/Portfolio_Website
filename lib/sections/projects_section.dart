import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';
import '../data/projects.dart';
import '../widgets/appear_on_scroll.dart';
import '../widgets/hover_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return Responsive(
      builder: (context, width) {
        // --- Yeni kırılımlar ---
        // 1024+   => 3 sütun (iPad Pro ve üstü)
        // 860–1023 => 2 sütun  (iPad Air dahil)
        // 720–859  => 2 sütun  (iPad mini dahil)
        // <720     => 1 sütun  (telefon)
        final int columns = width >= 1024
            ? 3
            : width >= 720
            ? 2
            : 1;

        // Kartları orta aralıkta biraz daha uzun tut (overflow'u önler)
        // childAspectRatio = width / height (küçük oran => daha uzun kart)
        final double ratio = switch (columns) {
          3 => 0.95, // geniş ekranda hafif uzun
          2 => 0.80, // iPad Air/mini'de daha uzun
          _ => 16 / 9, // tek sütunda modern kart oranı
        };

        // Yazı büyütme (Erişilebilirlik) durumunda oranı çok bozmadan telafi et
        final textScale = MediaQuery.of(
          context,
        ).textScaleFactor.clamp(1.0, 1.3);
        final effectiveRatio =
            ratio / textScale; // büyük fontta kartı biraz daha uzat

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: effectiveRatio,
              ),
              itemCount: demoProjects.length,
              itemBuilder: (context, i) {
                final p = demoProjects[i];

                return AppearOnScroll(
                  key: ValueKey('project-$i'),
                  offsetY: 20,
                  duration: Duration(milliseconds: 420 + i * 60),
                  child: HoverCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Başlık
                        Text(
                          p.title,
                          style: t.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Açıklama — orta/geniş ekrana göre satır sınırı
                        Text(
                          p.description,
                          style: t.textTheme.bodyMedium,
                          maxLines: columns == 1 ? 5 : 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: columns == 1 ? 12 : 16),

                        // Etiketler — Wrap ile taşma yok
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: p.tags
                              .map((e) => Chip(label: Text(e)))
                              .toList(),
                        ),
                        const SizedBox(height: 12),

                        // Aksiyonlar — Wrap ile akışkan
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
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
