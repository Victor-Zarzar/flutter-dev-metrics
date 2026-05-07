import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dev_metrics/app/features/settings/presentation/pages/settings_page.dart';
import 'package:dev_metrics/app/shared/theme/app_borders.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/widgets/app_top_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(title: 'home'.tr(), showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.xl.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'welcome'.tr(),
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: AppSpacing.sm.h),
              Text(
                'home_subtitle'.tr(),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              _HomeSectionTitle(title: 'quick_actions'.tr()),
              SizedBox(height: AppSpacing.md.h),

              Row(
                children: [
                  Expanded(
                    child: _HomeActionCard(
                      icon: Icons.dashboard,
                      label: 'view_metrics'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const DashboardPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _HomeActionCard(
                      icon: Icons.settings,
                      label: 'settings'.tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.xl.h),

              _HomeSectionTitle(title: 'overview'.tr()),
              SizedBox(height: AppSpacing.md.h),

              Row(
                children: [
                  Expanded(
                    child: _MiniStatCard(title: 'projects'.tr(), value: '12'),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _MiniStatCard(title: 'tasks'.tr(), value: '28'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeSectionTitle extends StatelessWidget {
  const _HomeSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    final colorScheme = context.theme.colorScheme;

    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w800,
        fontSize: 18.sp,
      ),
    );
  }
}

class _HomeActionCard extends StatelessWidget {
  const _HomeActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return InkWell(
      borderRadius: AppBorders.card,
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: AppBorders.card,
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28.sp, color: colorScheme.primary),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppBorders.card,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: AppSpacing.xs.h),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
