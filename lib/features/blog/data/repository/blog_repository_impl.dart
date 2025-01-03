import 'dart:io';

import 'package:blog_posting_app/core/error/exceptions.dart';
import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/features/blog/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_posting_app/features/blog/data/models/blog.dart';
import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';
import 'package:blog_posting_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  const BlogRepositoryImpl({
    required this.blogRemoteDataSource,
  });

  final BlogRemoteDataSource blogRemoteDataSource;

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String authorId,
    required String title,
    required String content,
    required List<String> topics,
    required File image,
  }) async {
    try {
      /// create a model
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        authorId: authorId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      /// upload image to the supabase storage, returning image url
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      /// update image url with the return data from uploadBlogImage() function
      blogModel.copyWith(
        imageUrl: imageUrl,
      );

      /// upload blog to supabase
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(
        blog: blogModel,
      );

      return right(
        uploadedBlog,
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();

      return right(
        blogs,
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
