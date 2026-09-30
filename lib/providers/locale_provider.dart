import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'locale';
  final SharedPreferences _prefs;
  Locale _locale;

  LocaleProvider(this._prefs)
      : _locale = Locale(_prefs.getString(_localeKey) ?? 'en');

  Locale get locale => _locale;

  bool get isEnglish => _locale.languageCode == 'en';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    _prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  void toggleLocale() {
    setLocale(isEnglish ? const Locale('as') : const Locale('en'));
  }

  static LocaleProvider of(BuildContext context) {
    return Provider.of<LocaleProvider>(context, listen: false);
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'as':
        return 'অসমীয়া'; // Assamese
      default:
        return 'English';
    }
  }

  String get currentLanguageName => getLanguageName(_locale.languageCode);
}
