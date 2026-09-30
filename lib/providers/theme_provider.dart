import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  final SharedPreferences _prefs;
  ThemeMode _themeMode;

  ThemeProvider(this._prefs)
      : _themeMode = ThemeMode.values[_prefs.getInt(_themeKey) ?? ThemeMode.system.index];

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs.setInt(_themeKey, mode.index);
    notifyListeners();
  }

  void toggleTheme() {
    setThemeMode(_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  static ThemeProvider of(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: false);
  }
}
