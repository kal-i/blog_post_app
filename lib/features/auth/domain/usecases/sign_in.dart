import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/core/usecase/usecase.dart';
import 'package:blog_posting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class SignIn implements UseCase<UserEntity, SignInParams> {
  const SignIn({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
