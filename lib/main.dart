import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signin_view.dart';
import 'package:blog_posting_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => serviceLocator<AuthBloc>(),
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
