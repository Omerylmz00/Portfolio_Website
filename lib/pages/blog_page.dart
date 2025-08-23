import 'package:flutter/material.dart';

import '../core/responsive.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Blog')),
      body: Responsive(
        builder: (context, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'Blog yakında! (V2’de markdown tabanlı yazılar eklenecek.)',
            style: t.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
