class PostMeta {
  final String slug;
  final String title;
  final String summary;
  final DateTime date;
  final List<String> tags;
  final String file;

  PostMeta({
    required this.slug,
    required this.title,
    required this.summary,
    required this.date,
    required this.tags,
    required this.file,
  });

  factory PostMeta.fromJson(Map<String, dynamic> j) => PostMeta(
    slug: j['slug'],
    title: j['title'],
    summary: j['summary'],
    date: DateTime.parse(j['date']),
    tags: (j['tags'] as List).cast<String>(),
    file: j['file'],
  );
}