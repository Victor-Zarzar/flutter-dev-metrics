import 'package:app_version_update/app_version_update.dart';
import 'package:app_version_update/data/models/app_version_result.dart';
import 'package:dev_metrics/app/routes/global_navigator.dart';
import 'package:dev_metrics/app/shared/utils/logger.dart';
import 'package:dev_metrics/app/shared/utils/task_runner.dart';
import 'package:dev_metrics/app/shared/utils/typedefs.dart';
import 'package:flutter/material.dart';

class VersionUpdateService {
  VersionUpdateService._();
  static final VersionUpdateService instance = VersionUpdateService._();

  FutureEither<AppVersionResult?> checkForUpdate({
    String? appleId,
    String? playStoreId,
  }) async {
    return runTask(() async {
      return await AppVersionUpdate.checkForUpdates(
        appleId: appleId,
        playStoreId: playStoreId,
      );
    }, requiresNetwork: true);
  }

  FutureEither<void> checkAndShowUpdate({
    String? appleId,
    String? playStoreId,
    bool mandatory = false,
  }) async {
    return runTask(() async {
      final result = await AppVersionUpdate.checkForUpdates(
        appleId: appleId,
        playStoreId: playStoreId,
      );

      if (result.canUpdate ?? false) {
        final context = rootContext;
        if (context == null) {
          AppLogger.warning('Cannot show update dialog: rootContext is null');
          return;
        }

        if (context.mounted) {
          AppVersionUpdate.showAlertUpdate(
            appVersionResult: result,
            context: context,
            mandatory: mandatory,
          );
        }
      }
    }, requiresNetwork: true);
  }

  FutureEither<void> showUpdateAlert({
    required AppVersionResult updateResult,
    bool mandatory = false,
    String? title,
    String? content,
    String? cancelText,
    String? updateText,
  }) async {
    return runTask(() async {
      final context = rootContext;
      if (context == null) return;

      AppVersionUpdate.showAlertUpdate(
        appVersionResult: updateResult,
        context: context,
        mandatory: mandatory,
        title: title ?? 'New version available',
        content: content ?? 'Would you like to update your application?',
        cancelButtonText: cancelText ?? 'UPDATE LATER',
        updateButtonText: updateText ?? 'UPDATE',
      );
    });
  }

  FutureEither<void> showUpdateBottomSheet({
    required AppVersionResult updateResult,
    bool mandatory = false,
    String? title,
    Widget? content,
  }) async {
    return runTask(() async {
      final context = rootContext;
      if (context == null) return;

      AppVersionUpdate.showBottomSheetUpdate(
        appVersionResult: updateResult,
        context: context,
        mandatory: mandatory,
        title: title ?? 'New version available',
        content: content,
      );
    });
  }

  FutureEither<void> showUpdatePage({
    required AppVersionResult updateResult,
    bool mandatory = false,
    Widget? page,
  }) async {
    return runTask(() async {
      final context = rootContext;
      if (context == null) return;

      AppVersionUpdate.showPageUpdate(
        appVersionResult: updateResult,
        context: context,
        mandatory: mandatory,
        page: page,
      );
    });
  }
}
