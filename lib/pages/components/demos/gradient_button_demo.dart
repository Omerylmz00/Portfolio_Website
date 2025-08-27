import 'package:flutter/material.dart';

import '../spec.dart';

class _GradientButtonPreview extends StatelessWidget {
  const _GradientButtonPreview();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Gradient Button Tapped!'),
          ),
        );
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0D3AC), Color(0xFFC9B885), Color(0xFFA18F6A)],
            stops: [0.0, 0.55, 1.0],
          ),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            'CTA',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

const _code = '''
InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gradient Button Tapped!')),
        );
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0D3AC), Color(0xFFC9B885), Color(0xFFA18F6A)],
            stops: [0.0, 0.55, 1.0],
          ),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            'CTA',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
''';

final ComponentSpec gradientButtonSpec = ComponentSpec(
  id: 'gradient_button',
  title: 'Gradient Button',
  subtitle: 'Altın tonlu gradient button örneği.',
  preview: (_) => const _GradientButtonPreview(),
  code: _code,
  tags: const ['button', 'gradient'],
);
