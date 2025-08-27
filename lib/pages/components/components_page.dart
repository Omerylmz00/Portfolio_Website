import 'package:flutter/material.dart';
import 'package:portfolio_site/pages/components/spec.dart';
import 'package:portfolio_site/widgets/hover_card.dart';

import 'component_detail_page.dart';
import 'registry.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  final ScrollController _gridCtrl = ScrollController();

  late final List<String> allTags;
  String selectedTag = 'All';

  // Tag bazlı filtre
  List<ComponentSpec> get _filtered {
    if (selectedTag == 'All') return kComponents;
    final needle = selectedTag.toLowerCase();
    return kComponents
        .where((c) => c.tags.any((t) => t.toLowerCase() == needle))
        .toList();
  }

  String _titleCase(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  Widget _filterBar(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          for (final tag in allTags)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                label: Text(_titleCase(tag)),
                selected: selectedTag == tag,
                onSelected: (_) => setState(() => selectedTag = tag),
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final set = <String>{};
    for (final c in kComponents) {
      set.addAll(c.tags.map((e) => e.trim()).where((e) => e.isNotEmpty));
    }
    final sorted = set.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    allTags = ['All', ...sorted];
  }

  @override
  void dispose() {
    _gridCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final w = MediaQuery.of(context).size.width;
    final cross = w >= 1200
        ? 3
        : w >= 800
        ? 2
        : 1;

    final items = _filtered;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Components Kütüphanesi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hazır mini bileşenler ve demo örnekleri. Filtrele, önizle, kopyala.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _filterBar(context),
          Expanded(
            child: Scrollbar(
              controller: _gridCtrl,
              thumbVisibility: true,
              child: GridView.builder(
                controller: _gridCtrl,
                primary: false,
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cross,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final it = items[i];
                  return HoverCard(
                    onTap: null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 140,
                            alignment: Alignment.center,
                            color: const Color.fromRGBO(
                              0,
                              0,
                              0,
                              1,
                            ).withOpacity(.08),
                            child: it.preview(context),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          it.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(it.subtitle),
                        const Spacer(),

                        Center(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.code),
                            label: const Text('Önizle / Kodu Gör'),
                            onPressed: () => _openDetail(context, i),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: const StadiumBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ComponentDetailPage(index: index)),
    );
  }
}
