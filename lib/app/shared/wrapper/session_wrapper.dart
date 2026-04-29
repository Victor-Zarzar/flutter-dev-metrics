import 'package:dev_metrics/app/features/auth/providers/session_provider.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SessionListenerWrapper extends StatefulWidget {
  final Widget child;
  const SessionListenerWrapper({super.key, required this.child});

  @override
  State<SessionListenerWrapper> createState() => _SessionListenerWrapperState();
}

class _SessionListenerWrapperState extends State<SessionListenerWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final session = Provider.of<SessionProvider>(context);
    if (session.status != SessionStatus.unknown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        FlutterNativeSplash.remove();
        if (session.status == SessionStatus.authenticated) {
          context.go(AppRoutes.home);
        } else if (session.status == SessionStatus.unauthenticated) {
          context.go(AppRoutes.home);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
