import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/core/usecase/no_params.dart';
import 'package:blog_posting_app/core/usecase/usecase.dart';
import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';
import 'package:blog_posting_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  const GetAllBlogs({
    required this.blogRepository,
  });

  final BlogRepository blogRepository;

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
