import 'dart:io';

import 'package:blog_posting_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({
    required UploadBlog uploadBlog,
  })  : _uploadBlog = uploadBlog,
        super(
          BlogInitial(),
        ) {
    on<BlogEvent>(
      /// anonymous function
      (event, emit) => emit(
        BlogLoading(),
      ),
    );
    on<BlogUpload>(_onBlogUpload);
  }

  final UploadBlog _uploadBlog;

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _uploadBlog(
      UploadBlogParams(
        authorId: event.authorId,
        title: event.title,
        content: event.content,
        topics: event.topics,
        image: event.image,
      ),
    );

    response.fold(
      (l) => emit(
        BlogError(
          message: l.message,
        ),
      ),
      (r) => emit(
        BlogSuccess(),
      ),
    );
  }
}
