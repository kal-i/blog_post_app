part of 'blog_bloc.dart';

sealed class BlogEvent {
  const BlogEvent();
}

final class BlogUpload extends BlogEvent {
  const BlogUpload({
    required this.authorId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
  });

  final String authorId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;
}
