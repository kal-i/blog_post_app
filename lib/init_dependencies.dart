import 'package:blog_posting_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_posting_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:blog_posting_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:blog_posting_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_posting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';

final serviceLocator = GetIt.instance;

/// register factory creates an instance every time
/// register lazy singleton preserve its state throughout app's lifecycle
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<SignUp>(
      () => SignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<SignIn>(
      () => SignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory<CurrentUser>(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        signUp: serviceLocator(),
        signIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
