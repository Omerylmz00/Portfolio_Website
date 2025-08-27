// DEMO’LARI içeri al
import 'demos/counter_demo.dart';
import 'demos/gradient_button_demo.dart';
import 'spec.dart';

final List<ComponentSpec> kComponents = [gradientButtonSpec, stepperTouchSpec];

// İsteğe bağlı yardımcılar:
Map<String, ComponentSpec> get kById => {for (final c in kComponents) c.id: c};

List<ComponentSpec> search(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return kComponents;
  return kComponents
      .where((c) {
        final haystack = [
          c.id,
          c.title,
          c.subtitle,
          ...c.tags,
          c.code,
        ].join(' ').toLowerCase();
        return haystack.contains(q);
      })
      .toList(growable: false);
}
