import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({
    super.key,
    required this.items,
    this.speed = 36,
    this.gap = 12,
    this.height = 40,
  });

  final List<String> items;
  final double speed;
  final double gap;
  final double height;

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_onTick); // ← sadece oluştur
  Duration _last = Duration.zero;
  double _dx = 0.0;
  double _contentWidth = 0.0;
  final _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // _ticker.start();  ❌ KALDIR
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _onTick(Duration now) {
    if (_last == Duration.zero) {
      _last = now;
      return;
    }
    final dtSec = (now - _last).inMicroseconds / 1e6;
    _last = now;

    final period = _contentWidth + widget.gap;
    if (period <= 0) return;

    _dx = (_dx + widget.speed * dtSec) % period;
    setState(() {});
  }

  void _measure() {
    final r = _contentKey.currentContext?.findRenderObject();
    if (r is RenderBox) setState(() => _contentWidth = r.size.width);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewW = constraints.maxWidth;
        final period = _contentWidth + widget.gap;
        final copies = period > 0 ? (viewW / period).ceil() + 2 : 2;

        return SizedBox(
          height: widget.height,
          child: VisibilityDetector(
            key: Key('skills-marquee-$hashCode'),
            onVisibilityChanged: (info) {
              final visible = info.visibleFraction > 0.01;
              if (visible) {
                if (!_ticker.isActive) {
                  _last = Duration
                      .zero; // yeniden başlatırken zaman farkını resetle
                  _ticker.start();
                }
              } else {
                if (_ticker.isActive) {
                  _ticker.stop();
                  _last = Duration.zero;
                }
              }
            },
            child: _MaskedStrip(
              dx: _dx,
              copies: copies,
              gap: widget.gap,
              height: widget.height,
              contentKey: _contentKey,
              items: widget.items,
            ),
          ),
        );
      },
    );
  }
}

// Mask ve satır içeriği (senin mevcut sürümünle aynı olabilir)
class _MaskedStrip extends StatelessWidget {
  const _MaskedStrip({
    required this.dx,
    required this.copies,
    required this.gap,
    required this.height,
    required this.contentKey,
    required this.items,
  });

  final double dx, gap, height;
  final int copies;
  final Key contentKey;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
        stops: [0.0, 0.08, 0.92, 1.0],
      ).createShader(rect),
      blendMode: BlendMode.dstIn,
      child: ClipRect(
        child: Stack(
          children: List.generate(copies, (k) {
            return Transform.translate(
              offset: Offset(
                -dx + k * (_RowContent.widthEstimate(items, gap)),
                0,
              ),
              child: _RowContent(
                key: k == 0 ? contentKey : null,
                items: items,
                gap: gap,
                labelStyle: t.textTheme.labelLarge,
                chipColor: t.colorScheme.surface,
                outline: t.colorScheme.outline.withOpacity(.2),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _RowContent extends StatelessWidget {
  const _RowContent({
    super.key,
    required this.items,
    required this.gap,
    required this.labelStyle,
    required this.chipColor,
    required this.outline,
  });

  final List<String> items;
  final double gap;
  final TextStyle? labelStyle;
  final Color chipColor;
  final Color outline;

  // kaba bir tahmin (ilk ölçüm gelmeden kopya konumlarını üretmek için)
  static double widthEstimate(List<String> items, double gap) {
    // tahmini: her chip ~ (metin uzunluğu * 8 + padding*2) + gap
    final textW = items.fold<double>(
      0,
      (s, e) => s + e.length * 8.0 + 28.0 + gap,
    );
    return textW > 0 ? textW : 1;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: OverflowBox(
        minWidth: 0,
        maxWidth: double.infinity,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final s in items)
              Padding(
                padding: EdgeInsets.only(right: gap),
                child: Chip(
                  label: Text(
                    s,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: labelStyle,
                  ),
                  side: BorderSide(color: outline),
                  backgroundColor: chipColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
