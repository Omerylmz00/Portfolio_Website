import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/post_repository.dart';
import '../data/post.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final repo = PostRepository();
  late Future<List<PostMeta>> fut;

  @override
  void initState() {
    super.initState();
    fut = repo.list();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Blog')),
      body: FutureBuilder<List<PostMeta>>(
        future: fut,
        builder: (c, s) {
          if (s.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (s.hasError) {
            return Center(child: Text('Hata: ${s.error}'));
          }
          final posts = s.data ?? [];
          if (posts.isEmpty) {
            return const Center(child: Text('Henüz yazı yok.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (_, i) {
              final p = posts[i];
              final date = '${p.date.year}.${p.date.month.toString().padLeft(2,'0')}.${p.date.day.toString().padLeft(2,'0')}';
              return ListTile(
                title: Text(p.title, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                subtitle: Text(p.summary),
                trailing: Text(date),
                onTap: () => context.go('/blog/${p.slug}'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              );
            },
          );
        },
      ),
    );
  }
}