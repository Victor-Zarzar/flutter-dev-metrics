import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/shared/theme/app_borders.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/widgets/app_top_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('${'launch_error'.tr()} $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(title: 'about'.tr()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.add_ic_call,
                size: 64.sp,
                color: colorScheme.primary,
                semanticLabel: 'informationicon'.tr(),
              ),

              SizedBox(height: AppSpacing.lg.h),

              Text(
                'about'.tr(),
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                  fontSize: 28.sp,
                ),
              ),

              SizedBox(height: AppSpacing.md.h),

              Text(
                'description'.tr(),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              InkWell(
                borderRadius: AppBorders.lg,
                onTap: () => _launchUrl('https://www.victorzarzar.com.br'),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  child: Text(
                    'developed'.tr(),
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
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
