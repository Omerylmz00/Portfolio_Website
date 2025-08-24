import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import '../widgets/hover_card.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final code = '''
DecoratedBox(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFE0D3AC), Color(0xFFC9B885), Color(0xFFA18F6A)],
    ),
    borderRadius: BorderRadius.all(Radius.circular(14)),
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    child: Text('CTA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
  ),
)''';

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Components')),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          HoverCard(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 160,
                    color: Colors.black.withOpacity(.08),
                    child: const Center(child: Text('Preview here')),
                  ),
                ),
                const SizedBox(height: 12),
                Text('GradientButton', style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('Altın tonlu gradient ile CTA düğmesi.'),
                const SizedBox(height: 12),
                HighlightView(code, language: 'dart', theme: githubTheme, padding: const EdgeInsets.all(12), textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}