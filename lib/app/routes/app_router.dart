import 'package:dev_metrics/app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dev_metrics/app/features/home/presentation/pages/home_page.dart';
import 'package:dev_metrics/app/features/settings/presentation/pages/settings_page.dart';
import 'package:dev_metrics/app/features/signin/presentation/pages/signin_page.dart';
import 'package:dev_metrics/app/layout/desktop_layout.dart';
import 'package:dev_metrics/app/layout/mobile_layout.dart';
import 'package:dev_metrics/app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:dev_metrics/app/shared/widgets/responsive.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static GoRouter createRouter(AuthViewModel authViewModel) {
    return GoRouter(
      initialLocation: AppRoute.home.path,
      refreshListenable: authViewModel,
      redirect: (context, state) {
        final bool isAuthenticated = authViewModel.isAuthenticated;
        final bool isOnSignIn = state.matchedLocation == AppRoute.signin.path;

        if (!isAuthenticated && !isOnSignIn) {
          return AppRoute.signin.path;
        }

        if (isAuthenticated && isOnSignIn) {
          return AppRoute.home.path;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppRoute.signin.path,
          name: AppRoute.signin.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const SignInPage(),
            );
          },
        ),
        ShellRoute(
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
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const HomePage(),
                );
              },
            ),
            GoRoute(
              path: AppRoute.dashboard.path,
              name: AppRoute.dashboard.name,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const DashboardPage(),
                );
              },
            ),
            GoRoute(
              path: AppRoute.settings.path,
              name: AppRoute.settings.name,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  child: const SettingsPage(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
