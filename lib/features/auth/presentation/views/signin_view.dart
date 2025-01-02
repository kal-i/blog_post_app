import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_field.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_gradient_button.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              AuthField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 15.0,
              ),
              AuthField(
                controller: _passwordController,
                hintText: 'Password',
                isObscureText: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const AuthGradientButton(
                text: 'Sign in',
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SignUpView.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColor.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
