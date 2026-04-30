import 'package:dev_metrics/app/config/app_config.dart';
import 'package:dev_metrics/app/shared/services/notification_service.dart';
import 'package:dev_metrics/app/shared/services/sentry_service.dart';
import 'package:dev_metrics/app/shared/wrapper/localization_wrapper.dart';
import 'package:dev_metrics/app/shared/wrapper/state_wrapper.dart';
import 'package:dev_metrics/app_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  await AppConfig.init();

  if (!kIsWeb) {
    await NotificationService.init();
    tz.initializeTimeZones();
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    SentryService.instance.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    SentryService.instance.captureException(error, stackTrace: stack);
    return true;
  };

  runApp(const LocalizationWrapper(child: StateWrapper(child: AppWidget())));
}
