import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/core/usecase/usecase.dart';
import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:blog_posting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/no_params.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  const CurrentUser({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
