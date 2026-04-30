import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/shared/theme/app_borders.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/widgets/app_top_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(title: 'dashboard'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.xl.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DashboardSection(
                title: 'overview'.tr(),
                child: Row(
                  children: [
                    Expanded(
                      child: _DashboardCard(
                        icon: Icons.add_ic_call,
                        title: 'projects'.tr(),
                        value: '12',
                      ),
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Expanded(
                      child: _DashboardCard(
                        icon: Icons.add_ic_call,
                        title: 'tasks'.tr(),
                        value: '28',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              _DashboardSection(
                title: 'performance'.tr(),
                child: Row(
                  children: [
                    Expanded(
                      child: _DashboardCard(
                        icon: Icons.add_ic_call,
                        title: 'productivity'.tr(),
                        value: '87%',
                      ),
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Expanded(
                      child: _DashboardCard(
                        icon: Icons.add_ic_call,
                        title: 'focus_time'.tr(),
                        value: '6h 40m',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              _DashboardSection(
                title: 'summary'.tr(),
                child: _DashboardSummaryCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardSection extends StatelessWidget {
  const _DashboardSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    final colorScheme = context.theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w800,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: AppSpacing.md.h),
        child,
      ],
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 28.sp,
            color: colorScheme.primary,
            semanticLabel: title,
          ),
          SizedBox(height: AppSpacing.md.h),
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

class _DashboardSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppBorders.card,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.add_ic_call,
            size: 28.sp,
            color: colorScheme.primary,
            semanticLabel: 'dashboard_summary_icon'.tr(),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Text(
              'dashboard_description'.tr(),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
