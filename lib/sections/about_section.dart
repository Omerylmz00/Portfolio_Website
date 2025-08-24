import 'package:flutter/material.dart';
import 'package:portfolio_site/sections/timeline_section.dart';
import 'package:portfolio_site/widgets/appear_on_scroll.dart';

import '../core/responsive.dart';
import '../widgets/animated_on_build.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Responsive(
      builder: (context, width) {
        final isNarrow = width < 860;
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hakkımda',
              style: t.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            AppearOnScroll(
              child: Text(
                "Üniversite son sınıf öğrencisiyim. Flutter, Swift, Backend ve AI/ML alanlarına ilgi duyuyorum.\n"
                "Amacım kullanıcı odaklı ürünler geliştirmek ve bildiklerimi toplulukla paylaşmak.",
                style: t.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 32),
            Divider(height: 1),
            const SizedBox(height: 32),
            AppearOnScroll(
              child: const TimelineSection(
                items: [
                  TimelineItem(
                    date: '2021–2023',
                    title: 'Bilgisayar Müh.',
                    desc: 'Özet...',
                  ),
                  TimelineItem(
                    date: '2024',
                    title: 'Staj / Part-time',
                    desc: 'Özet...',
                  ),
                  TimelineItem(
                    date: '2025',
                    title: 'Flutter + Swift + Backend',
                    desc: 'Özet...',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            if (!isNarrow)
              Row(
                children: const [
                  Expanded(
                    child: _HighlightCard(
                      title: '3+ Proje',
                      subtitle: 'Flutter prod deneyimi',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _HighlightCard(
                      title: 'AI/ML ilgisi',
                      subtitle: 'Küçük demo ve makaleler',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _HighlightCard(
                      title: 'Topluluk',
                      subtitle: 'Blog + Component paylaşımı',
                    ),
                  ),
                ],
              )
            else
              Column(
                children: const [
                  _HighlightCard(
                    title: '3+ Proje',
                    subtitle: 'Flutter prod deneyimi',
                  ),
                  SizedBox(height: 12),
                  _HighlightCard(
                    title: 'AI/ML ilgisi',
                    subtitle: 'Küçük demo ve makaleler',
                  ),
                  SizedBox(height: 12),
                  _HighlightCard(
                    title: 'Topluluk',
                    subtitle: 'Blog + Component paylaşımı',
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final String title, subtitle;
  const _HighlightCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return AnimatedOnBuild(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: t.colorScheme.outline.withOpacity(.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: t.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(subtitle, style: t.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
