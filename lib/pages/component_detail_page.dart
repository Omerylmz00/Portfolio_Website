import 'package:flutter/material.dart';

import '../models/component_model.dart';
import '../widgets/code_box.dart';
import '../widgets/phone_frame.dart';

class ComponentDetailPage extends StatelessWidget {
  final ComponentModel demo;
  const ComponentDetailPage({super.key, required this.demo});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width > 980;

    final preview = PhoneFrame(
      child: Center(child: demo.previewBuilder(context)),
    );

    final codeTab = CodeBox(code: demo.dartCode, height: 420);

    return Scaffold(
      appBar: AppBar(title: Text(demo.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sol: telefon
                  Expanded(flex: 5, child: preview),
                  const SizedBox(width: 24),
                  // Sağ: kod
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(demo.subtitle, style: t.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        Expanded(child: codeTab),
                      ],
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  preview,
                  const SizedBox(height: 20),
                  Text(demo.subtitle, style: t.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  codeTab,
                ],
              ),
      ),
    );
  }
}
