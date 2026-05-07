import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  static const _themeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  SharedPreferences? _storage;

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();

    final saved = _storage?.getString(_themeKey);

    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => ThemeMode.system,
    );

    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final storage = _storage ?? await SharedPreferences.getInstance();
    _storage = storage;

    await storage.setString(_themeKey, mode.name);
  }
}
