import 'package:dev_metrics/app/features/auth/data/presentation/pages/auth_form.dart';
import 'package:dev_metrics/app/features/auth/data/viewmodels/auth_viewmodel.dart';
import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:dev_metrics/app/routes/app_router_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final auth = context.read<AuthViewModel>();

    final success = await auth.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      context.goTo(AppRoute.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, _) {
        return Scaffold(
          body: AuthForm(
            titleKey: 'auth.signin.title',
            emailController: _emailController,
            passwordController: _passwordController,
            emailErrorKey: auth.emailErrorKey,
            passwordErrorKey: auth.passwordErrorKey,
            generalErrorKey: auth.generalErrorKey,
            submitLabelKey: 'auth.signin.submit',
            secondaryActionLabelKey: 'auth.signin.create_account',
            onSubmit: _handleSignIn,
            onSecondaryAction: () => context.goTo(AppRoute.signup),
            isLoading: auth.isLoading,
          ),
        );
      },
    );
  }
}
