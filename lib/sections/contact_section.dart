import 'package:flutter/material.dart';
import 'package:portfolio_site/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Responsive(
      builder: (context, width) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İletişim',
              style: t.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                _LinkButton(
                  icon: Icons.email,
                  label: 'E-posta',
                  onTap: () => _open('mailto:you@mail.com'),
                ),
                _LinkButton(
                  icon: Icons.link,
                  label: 'LinkedIn',
                  onTap: () => _open('https://linkedin.com/in/your'),
                ),
                _LinkButton(
                  icon: Icons.code,
                  label: 'GitHub',
                  onTap: () => _open('https://github.com/yourname'),
                ),
                _LinkButton(
                  icon: Icons.forum,
                  label: 'Twitter / X',
                  onTap: () => _open('https://x.com/your'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri))
      launchUrl(uri, mode: LaunchMode.externalApplication);
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
    final borderThickness = _hovering ? 2.0 : 1.2;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(borderThickness),
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
