import 'package:flutter/material.dart';

class TimelineItem {
  final String date; final String title; final String desc;
  const TimelineItem({required this.date, required this.title, required this.desc});
}

class TimelineSection extends StatelessWidget {
  final List<TimelineItem> items;
  const TimelineSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Timeline', style: t.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        ...items.map((e) => _RowItem(e)),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  final TimelineItem item;
  const _RowItem(this.item);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(item.date, style: t.textTheme.labelLarge)),
          SizedBox(
            width: 24,
            child: Column(children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: t.colorScheme.primary, shape: BoxShape.circle)),
              Container(width: 2, height: 54, margin: const EdgeInsets.symmetric(vertical: 4), color: t.dividerColor),
            ]),
          ),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.title, style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(item.desc, style: t.textTheme.bodyMedium),
            ]),
          ),
        ],
      ),
    );
  }
}