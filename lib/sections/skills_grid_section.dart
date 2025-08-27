import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../widgets/skills_widget.dart';

class SkillsGridSection extends StatelessWidget {
  final List<String> skills;
  const SkillsGridSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Text(
            'Kullandığım Teknolojiler',
            style: t.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),*/
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: skills.map((s) => SkillWidget(s)).toList(),
          ),
        ],
      ),
    );
  }
}
