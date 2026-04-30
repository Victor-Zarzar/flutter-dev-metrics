import 'package:dev_metrics/app/extensions/context_extension.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:dev_metrics/app/shared/enums/buttom_enums.dart';
import 'package:dev_metrics/app/shared/theme/app_spacing.dart';
import 'package:dev_metrics/app/shared/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  late final List<Map<String, dynamic>> _onboardingData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _onboardingData = [
      {
        'title': 'onboarding.onboarding_title_1'.tr(),
        'subtitle': 'onboarding.onboarding_subtitle_1'.tr(),
        'pageWidget': const FlutterLogo(size: 200),
      },
      {
        'title': 'onboarding.onboarding_title_2'.tr(),
        'subtitle': 'onboarding.onboarding_subtitle_2'.tr(),
        'pageWidget': const FlutterLogo(size: 200),
      },
      {
        'title': 'onboarding.onboarding_title_3'.tr(),
        'subtitle': 'onboarding.onboarding_subtitle_3'.tr(),
        'pageWidget': const FlutterLogo(size: 200),
      },
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    context.go(AppRoutes.signin);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return _OnboardingView(
      theme: theme,
      colorScheme: colorScheme,
      textTheme: textTheme,
      pageController: _pageController,
      currentIndex: _currentIndex,
      onboardingData: _onboardingData,
      onPageChanged: (index) => setState(() => _currentIndex = index),
      onGetStarted: _onGetStarted,
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView({
    required this.theme,
    required this.colorScheme,
    required this.textTheme,
    required this.pageController,
    required this.currentIndex,
    required this.onboardingData,
    required this.onPageChanged,
    required this.onGetStarted,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final PageController pageController;
  final int currentIndex;
  final List<Map<String, dynamic>> onboardingData;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: AppSpacing.lg.h,
                bottom: AppSpacing.md.h,
              ),
              child: Text(
                'Dev Metrics',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                  fontSize: 22.sp,
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg.w,
                            ),
                            child:
                                onboardingData[index]['pageWidget'] as Widget,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              onboardingData[index]['title'] as String,
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurface,
                                height: 1.2,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(height: AppSpacing.md.h),
                            Text(
                              onboardingData[index]['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.5,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(AppSpacing.xl.w),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.xl.h),
                  AppButton(
                    label: 'shared.get_started'.tr(),
                    onPressed: onGetStarted,
                    variant: ButtonVariant.primary,
                    width: ButtonSize.medium,
                  ),
                  SizedBox(height: AppSpacing.md.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
