import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  final Widget Function(BuildContext, double) builder;
  const Responsive({super.key, required this.builder});

  static const double maxWidth = 1100;
  static const double gutter = 24;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth.clamp(360, maxWidth).toDouble();
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: gutter),
              child: builder(context, w),
            ),
          ),
        );
      },
    );
  }
}
