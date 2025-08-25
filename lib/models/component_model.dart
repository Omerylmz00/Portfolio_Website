import 'package:flutter/material.dart';

class ComponentModel {
  final String id;
  final String title;
  final String subtitle;
  final String dartCode;
  final Widget Function(BuildContext context) previewBuilder;

  const ComponentModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dartCode,
    required this.previewBuilder,
  });
}
