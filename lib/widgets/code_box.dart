import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeBox extends StatelessWidget {
  final String code;
  final double height;

  const CodeBox({
    super.key,
    required this.code,
    this.height = 200, // sabit, taşma yok
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: t.colorScheme.surface.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.dividerColor.withOpacity(.35)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Dikey ve yatay scroll destekli
          SizedBox(
            height: height,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: HighlightView(
                      code,
                      language: 'dart',
                      theme: githubTheme,
                      textStyle: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Kopyala butonu
          Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              tooltip: 'Kodu kopyala',
              icon: const Icon(Icons.copy_rounded, size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Kod kopyalandı')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
