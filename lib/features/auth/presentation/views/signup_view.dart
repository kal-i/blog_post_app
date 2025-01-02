import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_field.dart';
import 'package:blog_posting_app/features/auth/presentation/components/auth_gradient_button.dart';
import 'package:blog_posting_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _navigateToSignIn() => Navigator.pop(
        context,
        SignInView.route(),
      );

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign Up.',
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          AuthField(
            controller: _nameController,
            hintText: 'Name',
          ),
          const SizedBox(
            height: 15.0,
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
            onPressed: _onSignUp,
            text: 'Sign up',
          ),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: _navigateToSignIn,
            child: RichText(
              text: TextSpan(
                text: 'Have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
  }
}
