import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Sadece dairesel fotoğraf + hafif "yüzen" (bob) animasyonu.
/// Web'de hover ile minicik büyür.
class AnimatedCircleAvatar extends StatefulWidget {
  const AnimatedCircleAvatar({
    super.key,
    required this.image,
    this.size = 260,
    this.borderWidth = 4,
    this.borderColor,
    this.shadow = true,
    this.bobAmplitude = 6, // piksel
    this.enableHoverScale = true,
  });

  final ImageProvider image;
  final double size;
  final double borderWidth;
  final Color? borderColor;
  final bool shadow;
  final double bobAmplitude;
  final bool enableHoverScale;

  @override
  State<AnimatedCircleAvatar> createState() => _AnimatedCircleAvatarState();
}

class _AnimatedCircleAvatarState extends State<AnimatedCircleAvatar>
    with TickerProviderStateMixin {
  late final AnimationController _bob; // sürekli yukarı-aşağı
  late final AnimationController _in; // ilk giriş (fade+scale)
  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _bob = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(); // sonsuz döngü
    _in = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
  }

  @override
  void dispose() {
    _bob.dispose();
    _in.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final borderColor =
        widget.borderColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;

    // Bobbing offset hesapla (sinüs)
    final dy =
        Tween<double>(begin: -widget.bobAmplitude, end: widget.bobAmplitude)
            .animate(CurvedAnimation(parent: _bob, curve: Curves.linear))
            .drive(Tween<double>(begin: 0, end: 2 * math.pi));

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedBuilder(
        animation: Listenable.merge([_bob, _in]),
        builder: (context, _) {
          final t = _bob.value; // 0..1
          final offsetY = math.sin(t * 2 * math.pi) * widget.bobAmplitude;

          return AnimatedScale(
            scale: (widget.enableHoverScale && _hover) ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 160),
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _in, curve: Curves.easeOut),
              child: ScaleTransition(
                scale: CurvedAnimation(parent: _in, curve: Curves.easeOutBack),
                child: Transform.translate(
                  offset: Offset(0, offsetY),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: widget.shadow
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(.07),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ]
                          : null,
                      border: Border.all(
                        color: borderColor,
                        width: widget.borderWidth,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ClipOval(
                      child: Image(
                        image: widget.image,
                        width: size,
                        height: size,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
