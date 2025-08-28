import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/app_colors.dart';
import 'package:portfolio_site/widgets/appear_on_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return Responsive(
      builder: (context, width) {
        return AppearOnScroll(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'İletişim',
                      textAlign: TextAlign.center,
                      style: t.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "Birlikte çalışalım mı?\n"
                      "Aşağıdaki linklerden bana ulaşabilir, görüşme planlayabilirsiniz.",
                      textAlign: TextAlign.center,
                      style: t.textTheme.bodyMedium?.copyWith(
                        color: t.colorScheme.onSurface.withOpacity(.75),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _LinkButton(
                          icon: Icons.email,
                          label: 'E-posta',

                          onTap: () => _open(
                            'mailto:omrf.ylmz00@gmail.com'
                            '?subject=Merhaba%20%C3%96mer%20Faruk'
                            '&body=K%C4%B1saca%20konu:%20',
                          ),
                        ),
                        _LinkButton(
                          icon: Icons.link,
                          label: 'LinkedIn',
                          onTap: () =>
                              _open('https://www.linkedin.com/in/omrfylmz00/'),
                        ),
                        _LinkButton(
                          icon: Icons.code,
                          label: 'GitHub',
                          onTap: () => _open('https://github.com/Omerylmz00'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        _LinkButton(
                          icon: Icons.event_available,
                          label: 'Görüşme Planla',
                          onTap: () =>
                              _open('https://cal.com/omeryilmaz00/15min'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovering = false;
  static const _radius = 12.0;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,

        padding: const EdgeInsets.all(2.0),
        constraints: const BoxConstraints(minHeight: 44, minWidth: 120),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius + 2),

          gradient: _hovering
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
          color: _hovering ? null : AppColors.ecru.withOpacity(.35),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.18),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Material(
          color: t.colorScheme.surface,
          borderRadius: BorderRadius.circular(_radius),
          child: InkWell(
            borderRadius: BorderRadius.circular(_radius),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 18,
                    color: t.colorScheme.onSurface.withOpacity(.9),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: t.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
