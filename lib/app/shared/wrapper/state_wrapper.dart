import 'package:dev_metrics/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_metrics/app/features/auth/providers/session_provider.dart';
import 'package:dev_metrics/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:dev_metrics/app/presentation/viewmodels/notification_viewmodel.dart';
import 'package:dev_metrics/app/shared/theme/theme_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StateWrapper extends StatelessWidget {
  final Widget child;

  const StateWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SessionProvider(repository: AuthRepositoryImpl()),
        ),
        ChangeNotifierProvider<NotificationViewModel>(
          create: (_) => NotificationViewModel(),
        ),
        ChangeNotifierProvider<LocaleViewModel>(
          create: (_) => LocaleViewModel(),
        ),
        ChangeNotifierProvider<UiProvider>(create: (_) => UiProvider()..init()),
      ],
      child: child,
    );
  }
}
