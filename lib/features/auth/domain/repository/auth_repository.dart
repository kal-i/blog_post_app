import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:blog_posting_app/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
