import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../data/post_repository.dart';

class PostPage extends StatefulWidget {
  final String slug;
  const PostPage({super.key, required this.slug});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final repo = PostRepository();
  String? md;
  String? title;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final meta = await repo.findBySlug(widget.slug);
    if (meta == null) {
      setState(() {
        md = '# 404\nYazı bulunamadı.';
        title = '404';
      });
      return;
    }
    final content = await repo.loadMarkdown(meta.file);
    setState(() {
      md = content;
      title = meta.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title ?? '...')),
      body: md == null
          ? const Center(child: CircularProgressIndicator())
          : Markdown(
              data: md!,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              styleSheet: MarkdownStyleSheet.fromTheme(t).copyWith(
                h1: t.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                p: t.textTheme.bodyLarge,
                blockquoteDecoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: t.colorScheme.primary, width: 3),
                  ),
                ),
              ),
            ),
    );
  }
}
