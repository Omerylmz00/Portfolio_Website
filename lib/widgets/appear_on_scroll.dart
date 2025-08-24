import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AppearOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetY;
  const AppearOnScroll({super.key, required this.child, this.duration = const Duration(milliseconds: 500), this.offsetY = 16});
  @override State<AppearOnScroll> createState() => _AppearOnScrollState();
}

class _AppearOnScrollState extends State<AppearOnScroll> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: widget.duration);
  bool _played = false;
  @override void dispose(){ _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString()),
      onVisibilityChanged: (i){ if(!_played && i.visibleFraction>0.15){ _c.forward(); _played=true; } },
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          final v = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic).value;
          return Opacity(
            opacity: v,
            child: Transform.translate(offset: Offset(0, (1 - v) * widget.offsetY), child: widget.child),
          );
        },
      ),
    );
  }
}