import 'package:blog_posting_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signin_view.dart';
import 'package:blog_posting_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_posting_app/features/blog/presentation/views/blog_view.dart';
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
        BlocProvider<AppUserCubit>(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider<BlogBloc>(
          create: (_) => serviceLocator<BlogBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// initially, it will trigger the AuthIsUserLoggedIn event,
/// checking whether user is present or not
/// if not logged in, emit auth error, otherwise, emit auth success
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(
          AuthIsUserLoggedIn(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Posting Application',
      theme: AppTheme.darkThemeMode,

      /// when state is AppUserLoggedIn, build SignInView
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return const BlogView();
          }
          return const SignInView();
        },
      ),
    );
  }
}
