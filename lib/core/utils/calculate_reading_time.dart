import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';

int calculateReadingTime({
  required String content,
}) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
