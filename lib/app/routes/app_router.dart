import 'package:dev_metrics/app/features/auth/data/presentation/pages/forgot_password_page.dart';
import 'package:dev_metrics/app/features/auth/data/presentation/pages/signin_page.dart';
import 'package:dev_metrics/app/features/auth/data/presentation/pages/signup_page.dart';
import 'package:dev_metrics/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dev_metrics/app/features/home/presentation/pages/home_page.dart';
import 'package:dev_metrics/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:dev_metrics/app/features/settings/presentation/pages/settings_page.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:dev_metrics/app/routes/global_navigator.dart';
import 'package:dev_metrics/app/routes/main_shell.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainRouteShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRouteNames.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              name: AppRouteNames.dashboard,
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              name: AppRouteNames.settings,
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: AppRouteNames.signup,
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: AppRoutes.signin,
      name: AppRouteNames.signin,
      builder: (context, state) => const SigninPage(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: AppRouteNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
  ],
);
