import 'package:dev_metrics/app/features/auth/providers/session_provider.dart';
import 'package:dev_metrics/app/routes/app_router.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class SessionListenerWrapper extends StatefulWidget {
  final Widget child;

  const SessionListenerWrapper({super.key, required this.child});

  @override
  State<SessionListenerWrapper> createState() => _SessionListenerWrapperState();
}

class _SessionListenerWrapperState extends State<SessionListenerWrapper> {
  SessionStatus? _lastStatus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final session = context.watch<SessionProvider>();

    if (session.status == SessionStatus.unknown) return;
    if (_lastStatus == session.status) return;

    _lastStatus = session.status;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      FlutterNativeSplash.remove();

      if (session.status == SessionStatus.authenticated) {
        appRouter.go(AppRoutes.home);
      }

      if (session.status == SessionStatus.unauthenticated) {
        appRouter.go(AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
