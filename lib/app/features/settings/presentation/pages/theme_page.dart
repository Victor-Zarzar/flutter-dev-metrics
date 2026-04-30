import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/shared/theme/app_borders.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/widgets/app_top_bar.dart';
import 'package:dev_metrics/app/shared/widgets/responsive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(title: 'select_theme'.tr(), showBackButton: true),
      body: const Responsive(
        mobile: _ThemeContent(maxContentWidth: 420),
        tablet: _ThemeContent(maxContentWidth: 560),
        desktop: _ThemeContent(maxContentWidth: 920),
      ),
    );
  }
}

class _ThemeContent extends StatelessWidget {
  const _ThemeContent({required this.maxContentWidth});

  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.xl.w),
          children: [
            _ThemeInfoCard(
              icon: Icons.devices_outlined,
              title: 'system_theme'.tr(),
              subtitle: 'system_theme_description'.tr(),
              selected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeInfoCard extends StatelessWidget {
  const _ThemeInfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppBorders.card,
        border: Border.all(
          color: selected ? colorScheme.primary : colorScheme.outlineVariant,
          width: selected ? 1.6 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 28.sp),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: AppSpacing.xs.h),
                Text(
                  subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: colorScheme.primary, size: 24.sp),
        ],
      ),
    );
  }
}
