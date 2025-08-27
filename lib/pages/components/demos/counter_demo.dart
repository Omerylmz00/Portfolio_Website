import 'package:flutter/material.dart';

import '../spec.dart';

class _CounterPreview extends StatefulWidget {
  const _CounterPreview();
  @override
  State<_CounterPreview> createState() => _CounterPreviewState();
}

class _CounterPreviewState extends State<_CounterPreview> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.08),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() => value--),
            splashRadius: 20,
            color: t.colorScheme.onSurface,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: Text('$value'),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => value++),
            splashRadius: 20,
            color: t.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

const _code = '''
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
''';

final ComponentSpec stepperTouchSpec = ComponentSpec(
  id: 'counter_basic',
  title: 'Basic Counter',
  subtitle: 'Sade artı/eksi sayacı (demo).',
  preview: (_) => const _CounterPreview(),
  code: _code,
  tags: const ['counter', 'chip'],
);
