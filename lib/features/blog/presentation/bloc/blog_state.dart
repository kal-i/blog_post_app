part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {}

final class BlogsFetchSuccess extends BlogState {
  const BlogsFetchSuccess({
    required this.blogs,
  });

  final List<BlogEntity> blogs;
}

final class BlogError extends BlogState {
  const BlogError({
    required this.message,
  });

  final String message;
}
