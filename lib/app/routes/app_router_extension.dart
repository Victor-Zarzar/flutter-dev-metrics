import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppRouteNavigation on BuildContext {
  void goTo(AppRoute route) => go(route.path);

  void pushTo(AppRoute route) => push(route.path);

  void goToNamed(AppRoute route) => goNamed(route.name);

  void pushToNamed(AppRoute route) => pushNamed(route.name);
}
