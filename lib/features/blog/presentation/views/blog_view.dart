import 'package:blog_posting_app/features/blog/presentation/views/add_new_blog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  void _navigateToAddNewBlog(BuildContext context) {
    Navigator.push(
      context,
      AddNewBlogView.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog Post App',
        ),
        actions: [
          IconButton(
            onPressed: () => _navigateToAddNewBlog(context),
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
    );
  }
}
