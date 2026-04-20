import 'package:dev_metrics/app/features/auth/data/presentation/pages/auth_form.dart';
import 'package:dev_metrics/app/features/auth/data/viewmodels/auth_viewmodel.dart';
import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:dev_metrics/app/routes/app_router_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final auth = context.read<AuthViewModel>();

    final success = await auth.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      context.goTo(AppRoute.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, _) {
        return Scaffold(
          body: AuthForm(
            titleKey: 'auth.signup.title',
            emailController: _emailController,
            passwordController: _passwordController,
            emailErrorKey: auth.emailErrorKey,
            passwordErrorKey: auth.passwordErrorKey,
            generalErrorKey: auth.generalErrorKey,
            submitLabelKey: 'auth.signup.submit',
            secondaryActionLabelKey: 'auth.signin.already_have_account',
            onSubmit: _handleSignUp,
            onSecondaryAction: () => context.goTo(AppRoute.signin),
            isLoading: auth.isLoading,
          ),
        );
      },
    );
  }
}
