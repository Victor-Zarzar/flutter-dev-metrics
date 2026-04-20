import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.titleKey,
    required this.emailController,
    required this.passwordController,
    required this.emailErrorKey,
    required this.passwordErrorKey,
    required this.generalErrorKey,
    required this.submitLabelKey,
    required this.secondaryActionLabelKey,
    required this.onSubmit,
    required this.onSecondaryAction,
    required this.isLoading,
  });

  final String titleKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? emailErrorKey;
  final String? passwordErrorKey;
  final String? generalErrorKey;
  final String submitLabelKey;
  final String secondaryActionLabelKey;
  final VoidCallback onSubmit;
  final VoidCallback onSecondaryAction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titleKey.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'auth.fields.email'.tr(),
                  border: const OutlineInputBorder(),
                  errorText: emailErrorKey?.tr(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'auth.fields.password'.tr(),
                  border: const OutlineInputBorder(),
                  errorText: passwordErrorKey?.tr(),
                ),
              ),
              if (generalErrorKey != null) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    generalErrorKey!.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(submitLabelKey.tr()),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: isLoading ? null : onSecondaryAction,
                child: Text(secondaryActionLabelKey.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
