import 'package:dev_metrics/app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:dev_metrics/app/routes/app_router.dart';
import 'package:dev_metrics/app/shared/theme/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiProvider, AuthViewModel>(
      builder: (context, uiProvider, authViewModel, _) {
        final router = AppRouter.createRouter(authViewModel);

        return MaterialApp.router(
          title: 'Dev Metrics',
          debugShowCheckedModeBanner: false,
          theme: uiProvider.lightTheme,
          darkTheme: uiProvider.darkTheme,
          themeMode: uiProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: router,
        );
      },
    );
  }
}
