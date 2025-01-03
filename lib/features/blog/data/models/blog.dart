import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';

class BlogModel extends BlogEntity {
  const BlogModel({
    required super.id,
    required super.authorId,
    super.authorName,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  /// we won't add the author name field in both toJson() and fromJson()
  /// because there are use-cases where they are not needed like uploading blog
  /// instead, we will update the blog model using the copyWith method
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      authorId: json['author_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      topics: List<String>.from(
            json['topics'],
          ) ??
          [],
      updatedAt: json['updated'] != null
          ? DateTime.parse(
              json['update_at'],
            )
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
