import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/core/common/components/loader.dart';
import 'package:blog_posting_app/core/utils/show_snackbar.dart';
import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_field.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_gradient_button.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _navigateToSignUp() => Navigator.push(
        context,
        SignUpView.route(),
      );

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignIn(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

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
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showSnackBar(
            context,
            state.message,
          );
        }

        if (state is AuthSuccess) {
          showSnackBar(
            context,
            state.user.toString(),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }

        return Form(
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
              AuthGradientButton(
                onPressed: _signIn,
                text: 'Sign in',
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: _navigateToSignUp,
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
        );
      },
    );
  }
}
