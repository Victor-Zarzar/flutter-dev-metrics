import 'package:dev_metrics/app/presentation/viewmodels/theme_viewmodel.dart';
import 'package:dev_metrics/app/routes/app_router.dart';
import 'package:dev_metrics/app/shared/theme/theme.dart';
import 'package:dev_metrics/app/shared/wrapper/screen_util_wrapper.dart';
import 'package:dev_metrics/app/shared/wrapper/session_wrapper.dart';
import 'package:dev_metrics/app/shared/wrapper/skeleton_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilWrapper(
      child: Consumer<ThemeViewModel>(
        builder: (context, themeVm, _) {
          return MaterialApp.router(
            title: 'Dev Metrics',
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(primaryColorHex: '#669c35'),
            darkTheme: buildDarkTheme(primaryColorHex: '#669c35'),
            themeMode: themeVm.themeMode,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routerConfig: appRouter,
            builder: (context, child) {
              Widget current = child!;
              current = SkeletonWrapper(child: current);
              current = SessionListenerWrapper(child: current);
              return current;
            },
          );
        },
      ),
    );
  }
}
