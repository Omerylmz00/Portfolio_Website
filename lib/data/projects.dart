class Project {
  final String title;
  final String description;
  final String? liveUrl;
  final String? repoUrl;
  final List<String> tags;

  Project({
    required this.title,
    required this.description,
    this.liveUrl,
    this.repoUrl,
    this.tags = const [],
  });
}

final demoProjects = <Project>[
  Project(
    title: 'AI Notes',
    description:
        'Flutter + Firebase ile not uygulaması. Basit text classification demo içerir.',
    liveUrl: null,
    repoUrl: 'https://github.com/yourname/ai-notes',
    tags: ['Flutter', 'Firebase', 'AI/ML'],
  ),
  Project(
    title: 'Swift Weather',
    description: 'iOS için SwiftUI ile hava durumu uygulaması.',
    repoUrl: 'https://github.com/yourname/swift-weather',
    tags: ['Swift', 'iOS'],
  ),
  Project(
    title: 'Portfolio (bu site)',
    description: 'Flutter Web ile kişisel portfolyo.',
    repoUrl: 'https://github.com/yourname/my_portfolio',
    tags: ['Flutter Web'],
  ),
];
