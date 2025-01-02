import 'package:blog_posting_app/core/secrets/app_secrets.dart';
import 'package:blog_posting_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:blog_posting_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            signUp: SignUp(
              authRepository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  supabaseClient: supabase.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Posting Application',
      theme: AppTheme.darkThemeMode,
      home: const SignInView(),
    );
  }
}
