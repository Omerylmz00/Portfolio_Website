import 'package:flutter/material.dart';

class SkillWidget extends StatefulWidget {
  final String text;
  const SkillWidget(this.text, {super.key});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final outline = t.colorScheme.outline.withOpacity(.22);
    final highlight = t.colorScheme.primary.withOpacity(.35);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_hover ? 1.04 : 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: t.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _hover ? highlight : outline),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.10),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Text(
          widget.text,
          style: t.textTheme.labelLarge,
          softWrap: false,
          overflow: TextOverflow.visible, // isimler kesilmesin
        ),
      ),
    );
  }
}
