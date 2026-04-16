import 'package:dev_metrics/app/routes/app_route.dart';
import 'package:flutter/material.dart';

class NavDestination {
  const NavDestination({
    required this.route,
    required this.icon,
    required this.labelKey,
  });

  final AppRoute route;
  final IconData icon;
  final String labelKey;
}
