import 'dart:io';

import 'package:blog_posting_app/features/blog/data/models/blog.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog({
    required BlogModel blog,
  });

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}
