import 'package:blog_posting_app/core/error/exceptions.dart';
import 'package:blog_posting_app/core/error/failure.dart';
import 'package:blog_posting_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:blog_posting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  /// Wrapper function for returning a user
  /// _getUser() func takes another func fn()
  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on AuthException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
