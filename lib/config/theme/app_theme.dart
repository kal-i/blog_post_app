import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppColor.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3.0,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: AppColor.backgroundColor,
    ),
    scaffoldBackgroundColor: AppColor.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27.0),
      enabledBorder: _border(),
      focusedBorder: _border(AppColor.gradient2),
    ),
  );
}
