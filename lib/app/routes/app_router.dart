import 'package:dev_metrics/app/features/auth/data/presentation/pages/signin_page.dart';
import 'package:dev_metrics/app/features/auth/data/presentation/pages/signup_page.dart';
import 'package:dev_metrics/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dev_metrics/app/features/home/presentation/pages/home_page.dart';
import 'package:dev_metrics/app/features/settings/presentation/pages/settings_page.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:dev_metrics/app/routes/global_navigator.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: 'signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.signin,
      name: 'signin',
      builder: (context, state) => const SignInPage(),
    ),
  ],
);
