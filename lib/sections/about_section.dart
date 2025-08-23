import 'package:flutter/material.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hakkımda',
              style: t.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedOnBuild(
              child: Text(
                "Üniversite son sınıf öğrencisiyim. Flutter, Swift, Backend ve AI/ML alanlarına ilgi duyuyorum.\n"
                "Amacım kullanıcı odaklı ürünler geliştirmek ve bildiklerimi toplulukla paylaşmak.",
                style: t.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _Skill('Flutter'),
                _Skill('Swift'),
                _Skill('Node.js'),
                _Skill('Dart'),
                _Skill('Python'),
                _Skill('TensorFlow'),
              ],
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

class _Skill extends StatelessWidget {
  final String text;
  const _Skill(this.text);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Chip(
      label: Text(text),
      side: BorderSide(color: t.colorScheme.outline.withOpacity(.2)),
      backgroundColor: t.colorScheme.surface,
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
