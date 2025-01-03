import 'dart:io';

import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/core/usecase/usecase.dart';
import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';
import 'package:blog_posting_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class UploadBlog implements UseCase<BlogEntity, UploadBlogParams> {
  const UploadBlog({
    required this.blogRepository,
  });

  final BlogRepository blogRepository;

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      authorId: params.authorId,
      title: params.title,
      content: params.content,
      topics: params.topics,
      image: params.image,
    );
  }
}

class UploadBlogParams {
  const UploadBlogParams({
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
