import 'package:flutter/material.dart';

import '../core/responsive.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Components')),
      body: Responsive(
        builder: (context, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'Component Library yakında! (V2’de kart + kod snippet + demo yer alacak.)',
            style: t.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
