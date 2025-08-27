import 'package:flutter/widgets.dart';

typedef PreviewBuilder = Widget Function(BuildContext context);

class ComponentSpec {
  final String id; // benzersiz: "gradient_button"
  final String title; // kart başlığı
  final String subtitle; // kısa açıklama
  final PreviewBuilder preview; // canlı önizleme
  final String code; // gösterilecek kod
  final List<String> tags; // filtreleme/arama için

  const ComponentSpec({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.preview,
    required this.code,
    this.tags = const [],
  });
}
