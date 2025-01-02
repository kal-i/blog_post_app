import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key, required this.text,});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColor.gradient1,
            AppColor.gradient2,
            AppColor.gradient3,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.transparentColor,
          fixedSize: const Size(395.0, 55.0),
          shadowColor: AppColor.transparentColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
