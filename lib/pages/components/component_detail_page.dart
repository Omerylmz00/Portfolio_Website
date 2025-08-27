import 'package:flutter/material.dart';
import 'package:portfolio_site/widgets/code_box.dart';

import 'registry.dart';

class ComponentDetailPage extends StatelessWidget {
  final int index;
  const ComponentDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = kComponents[index];
    final t = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 960;

    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _PreviewPane(child: item.preview(context))),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CodeBox(
                      title: 'Code',
                      code: item.code,
                      language: 'dart',
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  Text(item.subtitle, style: t.textTheme.titleMedium),
                  const SizedBox(height: 14),
                  _PreviewPane(child: item.preview(context)),
                  const SizedBox(height: 20),
                  CodeBox(title: 'Code', code: item.code),
                ],
              ),
      ),
    );
  }
}

class _PreviewPane extends StatelessWidget {
  final Widget child;
  const _PreviewPane({required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      height: 420,
      decoration: BoxDecoration(
        color: t.colorScheme.surface.withOpacity(
          t.brightness == Brightness.dark ? .25 : .7,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: t.colorScheme.outlineVariant.withOpacity(.5)),
      ),
      child: Center(child: child),
    );
  }
}
