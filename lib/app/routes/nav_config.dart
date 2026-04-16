import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:dev_metrics/app/routes/nav_destination.dart';
import 'package:flutter/material.dart';

class NavConfig {
  NavConfig._();

  static const List<NavDestination> items = [
    NavDestination(
      route: AppRoute.home,
      icon: Icons.home_outlined,
      labelKey: 'home',
    ),
    NavDestination(
      route: AppRoute.dashboard,
      icon: Icons.dashboard,
      labelKey: 'dashboard',
    ),
    NavDestination(
      route: AppRoute.settings,
      icon: Icons.settings_outlined,
      labelKey: 'settings',
    ),
  ];

  static const List<NavDestination> mobile = items;
  static const List<NavDestination> desktop = items;
}
