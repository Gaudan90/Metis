import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageManager extends ChangeNotifier {
  static final LanguageManager _instance = LanguageManager._internal();

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    await context.setLocale(Locale(languageCode));
    notifyListeners();
  }

  static const supportedLocales = [
    Locale('en'),
    Locale('it'),
    Locale('de'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
    Locale('fr'),
    Locale('es'),
  ];

  static const Map<String, Map<String, String>> languageData = {
    'en': {'name': 'English', 'flag': '🇬🇧', 'code': 'en'},
    'it': {'name': 'Italiano', 'flag': '🇮🇹', 'code': 'it'},
    'fr': {'name': 'Français', 'flag': '🇫🇷', 'code': 'fr'},
    'de': {'name': 'Deutsch', 'flag': '🇩🇪', 'code': 'de'},
    'es': {'name': 'Español', 'flag': '🇪🇸', 'code': 'es'},
    'ru': {'name': 'Русский', 'flag': '🇷🇺', 'code': 'ru'},
    'tr': {'name': 'Türkçe', 'flag': '🇹🇷', 'code': 'tr'},
    'zh': {'name': '中文', 'flag': '🇨🇳', 'code': 'zh'},
  };
}