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

      height: 520,
      decoration: BoxDecoration(
        gradient: AppGradients.heroFor(
          isDark ? Brightness.dark : Brightness.light,
        ),
      ),
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
                      child: AppearOnScroll(
                        offsetY: 70,
                        duration: const Duration(milliseconds: 4000),
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
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                PrimaryButton(
                                  outlined: true,
                                  label: 'CV’yi Görüntüle',
                                  onPressed: () async {
                                    final uri = Uri.parse(cvViewUrl);
                                    final ok = await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                      webOnlyWindowName:
                                          '_blank', // web’de yeni sekme
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
