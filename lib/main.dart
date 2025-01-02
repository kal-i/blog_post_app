import 'package:blog_posting_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
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
