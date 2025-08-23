import 'package:flutter/material.dart';

import '../core/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Responsive(
        builder: (context, _) => Row(
          children: [
            Text(
              '© ${DateTime.now().year} omeryilmaz.dev',
              style: t.textTheme.bodySmall,
            ),
            const Spacer(),
            Text('Built with Flutter', style: t.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
