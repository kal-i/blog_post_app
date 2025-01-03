import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/core/common/components/loader.dart';
import 'package:blog_posting_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_posting_app/core/utils/show_snackbar.dart';
import 'package:blog_posting_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_posting_app/features/blog/presentation/components/blog_card.dart';
import 'package:blog_posting_app/features/blog/presentation/views/add_new_blog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const BlogView(),
      );

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  void _navigateToAddNewBlog(BuildContext context) {
    Navigator.push(
      context,
      AddNewBlogView.route(),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(
          BlogFetchAllBlogs(),
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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogError) {
            showSnackBar(
              context,
              state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }

          if (state is BlogsFetchSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppColor.gradient1
                      : index % 3 == 1
                          ? AppColor.gradient2
                          : AppColor.gradient3,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
