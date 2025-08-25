import 'package:flutter/material.dart';

import '../models/component_model.dart';
import '../widgets/code_box.dart';
import '../widgets/hover_card.dart';
import 'component_detail_page.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final demos = _demos;

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Components')),
      body: LayoutBuilder(
        builder: (context, c) {
          final maxW = c.maxWidth;
          final cross = maxW >= 1200
              ? 3
              : maxW >= 820
              ? 2
              : 1;

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cross,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: cross == 1 ? 1.02 : 1.05,
            ),
            itemCount: demos.length,
            itemBuilder: (context, i) => _ComponentCard(demo: demos[i]),
          );
        },
      ),
    );
  }
}

class _ComponentCard extends StatelessWidget {
  final ComponentModel demo;
  const _ComponentCard({required this.demo});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return HoverCard(
      onTap: () {
        // Router kullanıyorsan yine çalışır; imperative push basit ve güvenli
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ComponentDetailPage(demo: demo)),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ComponentDetailPage(demo: demo),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CANLI mini preview (kart üstünde etkileşimli)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 180,
                    alignment: Alignment.center,
                    color: t.colorScheme.surface.withOpacity(.08),
                    child: demo.previewBuilder(context),
                  ),
                ),
                const SizedBox(height: 14),

                Text(
                  demo.title,
                  style: t.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(demo.subtitle, style: t.textTheme.bodyMedium),

                const SizedBox(height: 12),
                // Kart içindeki KOD – özet (taşma yok; dahili scroll var)
                CodeBox(code: demo.dartCode, height: 160),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// === ÖRNEK DEMOLAR ===
final _demos = <ComponentModel>[
  ComponentModel(
    id: 'gradient_button',
    title: 'GradientButton',
    subtitle: 'Altın tonlu gradient ile CTA düğmesi.',
    dartCode: '''
DecoratedBox(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFEFE0D3), Color(0xFFC9B885), Color(0xFFA18F6A)],
    ),
    borderRadius: BorderRadius.all(Radius.circular(14)),
  ),
  child: const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    child: Text(
      'CTA',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    ),
  ),
)
''',
    previewBuilder: (context) {
      // Kart üstü mini etkileşim
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFE0D3), Color(0xFFC9B885), Color(0xFFA18F6A)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            'CTA',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      );
    },
  ),

  // İkinci bir örnek: etkileşimli sayaç
  ComponentModel(
    id: 'counter_chip',
    title: 'Stepper Touch',
    subtitle: 'Sade artı/eksi sayacı (demo).',
    dartCode: '''
class CounterChip extends StatefulWidget {
  const CounterChip({super.key});
  @override
  State<CounterChip> createState() => _CounterChipState();
}
class _CounterChipState extends State<CounterChip> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.08),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() => value--)),
          CircleAvatar(backgroundColor: Colors.white, foregroundColor: Colors.black, child: Text('\$value')),
          IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => value++)),
        ],
      ),
    );
  }
}
''',
    previewBuilder: (context) => const _CounterChipPreview(),
  ),
];

class _CounterChipPreview extends StatefulWidget {
  const _CounterChipPreview();
  @override
  State<_CounterChipPreview> createState() => _CounterChipPreviewState();
}

class _CounterChipPreviewState extends State<_CounterChipPreview> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.12),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => setState(() => value--),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Text('$value'),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => value++),
            ),
          ],
        ),
      ),
    );
  }
}
