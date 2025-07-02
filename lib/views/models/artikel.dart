class Artikel {
  final String id;
  final String title;
  final String author;
  final String date;
  final String category;
  final String content;
  final String imagePath;

  Artikel({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.category,
    required this.content,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Artikel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}