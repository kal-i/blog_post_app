part of 'blog_bloc.dart';

sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {

}

final class BlogError extends BlogState {
  const BlogError({
    required this.message,
  });

  final String message;
}
