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
      border: _border(),
      enabledBorder: _border(),
      errorBorder: _border(
        AppColor.errorColor,
      ),
      focusedBorder: _border(
        AppColor.gradient2,
      ),
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppColor.backgroundColor,
      ),
      side: BorderSide.none,
    ),
  );
}
