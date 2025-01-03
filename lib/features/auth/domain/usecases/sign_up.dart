import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/core/usecase/usecase.dart';
import 'package:blog_posting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class SignUp implements UseCase<UserEntity, SignUpParams> {
  const SignUp({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;
}
