import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeBox extends StatefulWidget {
  final String title;
  final String code;
  final String language;

  const CodeBox({
    super.key,
    required this.title,
    required this.code,
    this.language = 'dart',
  });

  @override
  State<CodeBox> createState() => _CodeBoxState();
}

class _CodeBoxState extends State<CodeBox> {
  // Dikey ve yatay scroll için ayrı controller'lar
  final ScrollController _vCtrl = ScrollController();
  final ScrollController _hCtrl = ScrollController();
  bool _copied = false;
  Timer? _copyTimer;

  @override
  void dispose() {
    _vCtrl.dispose();
    _hCtrl.dispose();
    _copyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final isDark = t.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double boxHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 360;

        return Container(
          height: boxHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? t.colorScheme.surfaceContainerHighest.withOpacity(.25)
                : t.colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: t.colorScheme.outlineVariant.withOpacity(.5),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Üst toolbar
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? t.colorScheme.surface.withOpacity(.40)
                      : t.colorScheme.surfaceContainerHighest.withOpacity(.60),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: t.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: IconButton(
                        key: ValueKey(_copied),

                        tooltip: _copied ? 'Kopyalandı!' : 'Kopyala',
                        icon: Icon(
                          _copied ? Icons.check_rounded : Icons.copy_rounded,
                          size: 18,
                          color: _copied ? Colors.greenAccent.shade200 : null,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: widget.code),
                          );
                          if (!mounted) return;
                          setState(() => _copied = true);

                          _copyTimer?.cancel();
                          _copyTimer = Timer(
                            const Duration(milliseconds: 1200),
                            () {
                              if (mounted) setState(() => _copied = false);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  controller: _vCtrl,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _vCtrl,
                    padding: const EdgeInsets.all(16),
                    child: Scrollbar(
                      controller: _hCtrl,
                      thumbVisibility: true,
                      notificationPredicate: (notif) =>
                          notif.metrics.axis == Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: _hCtrl,
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            // Kod satırı kısa ise bile görünüm boşluğu doldursun
                            minWidth: constraints.maxWidth,
                          ),
                          child: HighlightView(
                            widget.code,
                            language: widget.language,
                            theme: isDark ? atomOneDarkTheme : githubTheme,
                            textStyle: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
