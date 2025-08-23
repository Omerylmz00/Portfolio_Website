import 'package:flutter/material.dart';

class AnimatedOnBuild extends StatefulWidget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  const AnimatedOnBuild({
    super.key,
    required this.child,
    this.offset = const Offset(0, 24),
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedOnBuild> createState() => _AnimatedOnBuildState();
}

class _AnimatedOnBuildState extends State<AnimatedOnBuild>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(
      parent: _c,
      curve: Interval(0.0, 1.0, curve: widget.curve),
    );
    _slide = Tween<Offset>(
      begin: widget.offset / 100,
      end: Offset.zero,
    ).animate(_opacity);

    Future.delayed(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
