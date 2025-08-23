import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/app_gradients.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';
import '../widgets/animated_circle_avatar.dart';
import '../widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      height: 520,
      decoration: const BoxDecoration(gradient: AppGradients.hero),
      child: Stack(
        children: [
          Responsive(
            builder: (context, width) {
              return SizedBox(
                height: 520,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Merhaba, ben Ömer Faruk Yılmaz",
                            style: t.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Flutter • Swift • Backend • AI/ML ile ürün geliştiren bir yazılım geliştirici adayıyım.\n"
                            "Bu sitede projelerimi, yazılarımı ve Flutter component’larımı bulabilirsin.",
                            style: t.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              PrimaryButton(
                                label: 'Projelerime Göz At',
                                onPressed: () {
                                  // Scroll'u home_page.dart içinden tetikliyoruz, burada sadece örnek:
                                  // idealde bir callback gelirdi; MVP'de CTA kullanıcıyı en üste bırakıyor.
                                  Scrollable.ensureVisible(
                                    context,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              PrimaryButton(
                                outlined: true,
                                label: 'CV İndir',
                                onPressed: () async {
                                  final uri = Uri.parse(
                                    'https://your-cv-link.com',
                                  );
                                  if (await canLaunchUrl(uri))
                                    launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    AnimatedCircleAvatar(
                      image: const AssetImage(
                        'assets/images/me.jpeg',
                      ), // görsel yolunu kendine göre ayarla
                      size: width < 900 ? 180 : 300, // responsive boyut
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackdrop extends StatefulWidget {
  const _AnimatedBackdrop();

  @override
  State<_AnimatedBackdrop> createState() => _AnimatedBackdropState();
}

class _AnimatedBackdropState extends State<_AnimatedBackdrop>
    with TickerProviderStateMixin {
  late AnimationController a1;
  late AnimationController a2;

  @override
  void initState() {
    super.initState();
    a1 = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);
    a2 = AnimationController(vsync: this, duration: const Duration(seconds: 14))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    a1.dispose();
    a2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c1 = Theme.of(context).colorScheme.primary.withOpacity(.18);
    final c2 = Theme.of(context).colorScheme.secondary.withOpacity(.12);
    return Positioned.fill(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: a1,
            builder: (_, __) => Positioned(
              left: 60 + 20 * (a1.value - .5) * 2,
              top: 80 + 10 * (a1.value - .5) * 2,
              child: _blob(220, c1),
            ),
          ),
          AnimatedBuilder(
            animation: a2,
            builder: (_, __) => Positioned(
              right: 80 + 30 * (a2.value - .5) * 2,
              bottom: 100 + 15 * (a2.value - .5) * 2,
              child: _blob(260, c2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * .46),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.6),
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}
