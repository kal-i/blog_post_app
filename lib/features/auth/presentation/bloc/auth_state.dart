part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  const AuthSuccess({
    required this.userId,
  });

  final String userId;
}

final class AuthError extends AuthState {
  const AuthError({
    required this.message,
  });

  final String message;
}