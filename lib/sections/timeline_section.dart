import 'package:flutter/material.dart';

class TimelineItem {
  final String? date;
  final DateTime? start;
  final DateTime? end;
  final String title;
  final String desc;

  const TimelineItem({
    required this.title,
    required this.desc,
    this.date,
    this.start,
    this.end,
  });

  bool get ongoing => start != null && end == null;

  String get label {
    if (start == null) return date ?? '';
    return _formatRange(start!, end);
  }

  static int compare(TimelineItem a, TimelineItem b) {
    final aO = a.ongoing, bO = b.ongoing;
    if (aO != bO) return aO ? -1 : 1;

    final aEnd = a.end ?? DateTime(9999);
    final bEnd = b.end ?? DateTime(9999);
    final byEnd = bEnd.compareTo(aEnd);
    if (byEnd != 0) return byEnd;

    final aStart = a.start ?? DateTime(0);
    final bStart = b.start ?? DateTime(0);
    return bStart.compareTo(aStart);
  }
}

class TimelineSection extends StatelessWidget {
  final List<TimelineItem> items;
  const TimelineSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    final hasDates = items.any((e) => e.start != null);
    final list = hasDates
        ? (List.of(items)..sort(TimelineItem.compare))
        : items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timeline',
          style: t.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        for (int i = 0; i < list.length; i++)
          _RowItem(item: list[i], isLast: i == list.length - 1),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  final TimelineItem item;
  final bool isLast;
  const _RowItem({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 140,
              child: Text(item.label, style: t.textTheme.labelLarge),
            ),

            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: t.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isLast ? Colors.transparent : t.dividerColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: t.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFC9B885),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(item.desc, style: t.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatRange(DateTime start, DateTime? end) {
  const monthsTr = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];
  final s = '${monthsTr[start.month - 1]} ${start.year}';
  final e = end == null
      ? 'Devam Ediyor'
      : '${monthsTr[end.month - 1]} ${end.year}';
  return '$s – $e';
}
