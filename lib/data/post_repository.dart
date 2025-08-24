import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'post.dart';

class PostRepository {
  Future<List<PostMeta>> list() async {
    final txt = await rootBundle.loadString('assets/posts/index.json');
    final arr = jsonDecode(txt) as List;
    final items = arr.map((e) => PostMeta.fromJson(e)).toList();
    items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }

  Future<String> loadMarkdown(String assetPath) async {
    return rootBundle.loadString(assetPath);
  }

  Future<PostMeta?> findBySlug(String slug) async {
    final items = await list();
    try { return items.firstWhere((e) => e.slug == slug); }
    catch (_) { return null; }
  }
}