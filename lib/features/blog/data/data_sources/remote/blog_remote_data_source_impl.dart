import 'dart:io';

import 'package:blog_posting_app/core/error/exceptions.dart';
import 'package:blog_posting_app/features/blog/data/data_sources/remote/blog_remote_data_source.dart';
import 'package:blog_posting_app/features/blog/data/models/blog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  const BlogRemoteDataSourceImpl({
    required this.supabaseClient,
  });
  final SupabaseClient supabaseClient;

  @override
  Future<BlogModel> uploadBlog({
    required BlogModel blog,
  }) async {
    try {
      final blogData = await supabaseClient
          .from(
            'blogs',
          )
          .insert(
            blog.toJson(),
          )
          .select();

      return BlogModel.fromJson(
        blogData.first,
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from(
            'blog_images',
          )
          .upload(
            blog.id,

            /// path
            image,
          );

      return supabaseClient.storage
          .from(
            'blog_images',
          )
          .getPublicUrl(
            blog.id,
          );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      /// fetch all blogs and the name of author from profiles table
      /// with the use of joins
      final blogModels = await supabaseClient
          .from(
            'blogs',
          )
          .select(
            '*, profiles (name)',
          );

      return blogModels
          .map(
            (blog) => BlogModel.fromJson(
              blog,
            ).copyWith(
              /// [table][column field]
              authorName: blog['profiles']['name'],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
