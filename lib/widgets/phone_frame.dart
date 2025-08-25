import 'package:flutter/material.dart';

/// Basit bir telefon çerçevesi (detay sayfasında canlı demo için)
class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return AspectRatio(
      aspectRatio: 9 / 19.5, // iPhone benzeri oran
      child: Container(
        decoration: BoxDecoration(
          color: t.colorScheme.surface.withOpacity(.06),
          border: Border.all(color: t.colorScheme.outline.withOpacity(.3)),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.45),
              blurRadius: 40,
              spreadRadius: -10,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // ekran
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: t.colorScheme.surfaceContainerHighest.withOpacity(.18),
                ),
                child: child,
              ),
            ),
            // üst notch
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: 120,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.4),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
