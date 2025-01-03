part of 'app_user_cubit.dart';

sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  const AppUserLoggedIn({
    required this.user,
  });

  final UserEntity user;
}

/// core cannot depend on feature
/// but features can depend on core
