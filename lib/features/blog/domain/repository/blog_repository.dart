import 'dart:io';

import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String authorId,
    required String title,
    required String content,
    required List<String> topics,
    required File image,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
