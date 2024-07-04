import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_palette.dart';
import 'package:flutter_blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInPage(),
      );

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              AuthField(
                hint: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hint: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 30),
              AuthGradientButton(
                text: 'Sign In',
                callbackFunction: () {
                  formKey.currentState!.validate();
                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    children: [
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: AppPalette.gradient2))
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
