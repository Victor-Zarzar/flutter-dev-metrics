import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/features/auth/providers/auth_provider.dart';
import 'package:dev_metrics/app/shared/enums/buttom_enums.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/utils/app_utils.dart';
import 'package:dev_metrics/app/shared/widgets/app_button.dart';
import 'package:dev_metrics/app/shared/widgets/app_text_field.dart';
import 'package:dev_metrics/app/shared/widgets/app_top_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    final isLoading = context.select((AuthProvider p) => p.isLoading);

    final cs = context.theme.colorScheme;
    final tt = context.theme.textTheme;

    Future<void> handleForgotPassword() async {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }

      context.read<AuthProvider>().forgotPassword(
        context: context,
        email: emailController.text,
      );
    }

    return Scaffold(
      appBar: const AppTopBar(title: ''),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.xl.h),
                Text(
                  'auth.forgot_password_title'.tr(),
                  style: tt.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.sm.h),
                Text(
                  'auth.forgot_password_subtitle'.tr(),
                  textAlign: TextAlign.center,
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                SizedBox(height: AppSpacing.xxxl.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: emailController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.emailAddress,
                        label: 'auth.email'.tr(),
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (v) {
                          if (AppUtils.isBlank(v)) {
                            return 'auth.email_required'.tr();
                          }
                          if (!AppUtils.isValidEmail(v!)) {
                            return 'auth.email_invalid'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                      AppButton(
                        label: 'Send Reset Link',
                        isLoading: isLoading,
                        onPressed: isLoading ? null : handleForgotPassword,
                        width: ButtonSize.large,
                        isFullWidth: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xxxl.h),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'auth.back_to_login'.tr(),
                    style: tt.labelLarge?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.xl.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
