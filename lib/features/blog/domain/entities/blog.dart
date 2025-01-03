class BlogEntity {
  const BlogEntity({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });

  final String id;
  final String authorId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;
}
