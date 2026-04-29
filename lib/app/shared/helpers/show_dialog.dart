import 'dart:ui';

import 'package:dev_metrics/app/routes/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<T?> showAppDialog<T>({
  required Widget child,
  bool hasBlur = true,
  double blurSigma = 5.0,
  Color barrierColor = Colors.black26,
  bool dismissible = true,
  Duration duration = const Duration(milliseconds: 300),
}) {
  final context = rootContext;
  if (context == null) return Future.value(null);

  return showGeneralDialog<T>(
    context: context,
    barrierColor: barrierColor,
    barrierDismissible: dismissible,
    barrierLabel: 'AppDialog',
    transitionDuration: duration,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curve = Curves.easeInOut.transform(animation.value);
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: hasBlur ? (blurSigma * animation.value) : 0,
          sigmaY: hasBlur ? (blurSigma * animation.value) : 0,
        ),
        child: Opacity(
          opacity: animation.value,
          child: Transform.scale(scale: 0.9 + (0.1 * curve), child: child),
        ),
      );
    },
  );
}

Future<T?> showCustomDialogue<T>({
  required Widget child,
  bool hasBlur = true,
}) => showAppDialog<T>(child: child, hasBlur: hasBlur);
