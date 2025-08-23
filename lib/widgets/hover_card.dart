import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/app_colors.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovering = false;

  static const _innerRadius = 18.0;
  static const _hoverScale = 1.02;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final borderThickness = hovering ? 2.0 : 1.2;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..scale(hovering ? _hoverScale : 1.0),

        padding: EdgeInsets.all(borderThickness),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_innerRadius + 2),

          gradient: hovering
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.champagne,
                    AppColors.ecru,
                    AppColors.brass,
                  ],
                )
              : null,

          color: hovering ? null : AppColors.ecru.withOpacity(.35),

          boxShadow: hovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.20),
                    blurRadius: 30,
                    offset: const Offset(0, 18),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),

        child: Container(
          decoration: BoxDecoration(
            color: t.colorScheme.surface,
            borderRadius: BorderRadius.circular(_innerRadius),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(_innerRadius),
              onTap: widget.onTap,
              child: Padding(padding: widget.padding, child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}
