import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/app_gradients.dart';
import 'package:portfolio_site/widgets/appear_on_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';
import '../widgets/animated_circle_avatar.dart';
import '../widgets/primary_button.dart';

const cvFileId = '1l-TcWEo8T0r62GpZ2iDforbf_RfqhvrK';
const cvViewUrl = 'https://drive.google.com/file/d/$cvFileId/view?usp=sharing';
const cvDownloadUrl =
    'https://drive.google.com/uc?export=download&id=$cvFileId';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final isDark = t.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,

      constraints: BoxConstraints(minHeight: 520),
      decoration: BoxDecoration(
        gradient: AppGradients.heroFor(
          isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      child: Stack(
        children: [
          Responsive(
            builder: (context, width) {
              //final isVeryNarrow = width < 420;
              final isNarrow = width < 760;
              final double avatarSize = width < 380
                  ? 140
                  : (width < 900 ? 180 : 300);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: isNarrow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppearOnScroll(
                            offsetY: 70,
                            duration: const Duration(milliseconds: 4000),
                            child: Column(
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

                                // ✅ BUTONLAR: Row yerine Wrap
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 10,
                                  children: [
                                    PrimaryButton(
                                      label: 'İletişime Geç',
                                      onPressed: () {
                                        Scrollable.ensureVisible(
                                          context,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                        );
                                      },
                                    ),
                                    PrimaryButton(
                                      outlined: true,
                                      label: 'CV’yi Görüntüle',
                                      onPressed: () async {
                                        final uri = Uri.parse(cvViewUrl);
                                        final ok = await launchUrl(
                                          uri,
                                          mode: LaunchMode.externalApplication,
                                          webOnlyWindowName: '_blank',
                                        );
                                        if (!ok && context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('CV açılamadı.'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedCircleAvatar(
                              image: const AssetImage(
                                'assets/images/me_2.jpeg',
                              ),
                              size: avatarSize,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppearOnScroll(
                              offsetY: 70,
                              duration: const Duration(milliseconds: 4000),
                              child: Column(
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

                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 10,
                                    children: [
                                      PrimaryButton(
                                        label: 'İletişime Geç',
                                        onPressed: () {
                                          Scrollable.ensureVisible(
                                            context,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                          );
                                        },
                                      ),
                                      PrimaryButton(
                                        outlined: true,
                                        label: 'CV’yi Görüntüle',
                                        onPressed: () async {
                                          final uri = Uri.parse(cvViewUrl);
                                          final ok = await launchUrl(
                                            uri,
                                            mode:
                                                LaunchMode.externalApplication,
                                            webOnlyWindowName: '_blank',
                                          );
                                          if (!ok && context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text('CV açılamadı.'),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          AnimatedCircleAvatar(
                            image: const AssetImage('assets/images/me_2.jpeg'),
                            size: avatarSize,
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
