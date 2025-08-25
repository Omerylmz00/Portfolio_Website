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
    title: 'Stayzi - Airbnb Clone',
    description:
        'Flutter ve FastAPI kullanarak geliştirilmiş Airbnb benzeri uygulama.',
    liveUrl: null,
    repoUrl: 'https://github.com/Omerylmz00/Stayzi',
    tags: ['Flutter', 'FastAPI', 'PostgreSQL'],
  ),
  Project(
    title: 'STING - TÜBİTAK 1001 Projesi',
    description:
        'Çocukluk çağı akut lösemisi için dijital ikiz yaklaşımı ve derin öğrenme ile ilaç yeniden konumlandırma karar destek sistemi geliştirmeyi amaçlayan bir TÜBİTAK 1001 projesidir. ',
    repoUrl: 'https://github.com/tubitaksting',
  ),
  Project(
    title: 'Portfolio (bu site)',
    description: 'Flutter Web ile kişisel portfolyo.',
    repoUrl: 'https://github.com/Omerylmz00/Portfolio_Website',
    tags: ['Flutter Web'],
  ),
];
