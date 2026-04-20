import 'package:dev_metrics/app/features/auth/data/presentation/pages/signin_page.dart';
import 'package:dev_metrics/app/features/auth/data/presentation/pages/signup_page.dart';
import 'package:dev_metrics/app/features/auth/data/viewmodels/auth_viewmodel.dart';
import 'package:dev_metrics/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dev_metrics/app/features/home/presentation/pages/home_page.dart';
import 'package:dev_metrics/app/features/settings/presentation/pages/settings_page.dart';
import 'package:dev_metrics/app/layout/desktop_layout.dart';
import 'package:dev_metrics/app/layout/mobile_layout.dart';
import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:dev_metrics/app/shared/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final Set<String> _publicPaths = {
    AppRoute.signin.path,
    AppRoute.signup.path,
  };

  static GoRouter createRouter(AuthViewModel authViewModel) {
    return GoRouter(
      initialLocation: AppRoute.home.path,
      refreshListenable: authViewModel,
      redirect: (_, state) => _handleRedirect(
        isAuthenticated: authViewModel.isAuthenticated,
        location: state.matchedLocation,
      ),
      routes: [..._authRoutes(), _appShellRoute()],
    );
  }

  static String? _handleRedirect({
    required bool isAuthenticated,
    required String location,
  }) {
    final isPublicRoute = _publicPaths.contains(location);

    if (!isAuthenticated && !isPublicRoute) {
      return AppRoute.signin.path;
    }

    if (isAuthenticated && isPublicRoute) {
      return AppRoute.home.path;
    }

    return null;
  }

  static List<RouteBase> _authRoutes() {
    return [
      GoRoute(
        path: AppRoute.signin.path,
        name: AppRoute.signin.name,
        pageBuilder: (context, state) =>
            _buildPage(state: state, child: const SignInPage()),
      ),
      GoRoute(
        path: AppRoute.signup.path,
        name: AppRoute.signup.name,
        pageBuilder: (context, state) =>
            _buildPage(state: state, child: const SignUpPage()),
      ),
    ];
  }

  static ShellRoute _appShellRoute() {
    return ShellRoute(
      builder: (context, state, child) {
        return Responsive(
          mobile: MobileLayout(child: child),
          tablet: MobileLayout(child: child),
          desktop: DesktopLayout(child: child),
        );
      },
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          pageBuilder: (context, state) =>
              _buildPage(state: state, child: const HomePage()),
        ),
        GoRoute(
          path: AppRoute.dashboard.path,
          name: AppRoute.dashboard.name,
          pageBuilder: (context, state) =>
              _buildPage(state: state, child: const DashboardPage()),
        ),
        GoRoute(
          path: AppRoute.settings.path,
          name: AppRoute.settings.name,
          pageBuilder: (context, state) =>
              _buildPage(state: state, child: const SettingsPage()),
        ),
      ],
    );
  }

  static NoTransitionPage<void> _buildPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return NoTransitionPage<void>(key: state.pageKey, child: child);
  }
}
