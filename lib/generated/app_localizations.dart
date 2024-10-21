import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
    Locale('fr'),
    Locale('es'),
    Locale('de'),
    Locale('tr'),
    Locale('ru'),
    Locale('zh'),
  ];

  String get helloWorld {
    return intl.Intl.message(
      'Hello World',
      name: 'helloWorld',
      desc: 'The conventional newborn programmer greeting',
      locale: localeName,
    );
  }

  String welcomeMessage(String username) {
    return intl.Intl.message(
      'Welcome $username',
      name: 'welcomeMessage',
      desc: 'Welcome message for the user',
      args: [username],
      locale: localeName,
    );
  }

  // Aggiungi qui altri metodi per le tue stringhe localizzate

  String get settings {
    return intl.Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Title for the settings page',
      locale: localeName,
    );
  }

  String get language {
    return intl.Intl.message(
      'Language',
      name: 'language',
      desc: 'Label for language selection',
      locale: localeName,
    );
  }

  String get italian {
    return intl.Intl.message(
      'Italian',
      name: 'italian',
      desc: 'Name of the Italian language',
      locale: localeName,
    );
  }

  String get english {
    return intl.Intl.message(
      'English',
      name: 'english',
      desc: 'Name of the English language',
      locale: localeName,
    );
  }

  String get french {
    return intl.Intl.message(
      'French',
      name: 'french',
      desc: 'Name of the French language',
      locale: localeName,
    );
  }

  String get russian {
    return intl.Intl.message(
      'Russian',
      name: 'russian',
      desc: 'Name of the Russian language',
      locale: localeName,
    );
  }

  String get chinese {
    return intl.Intl.message(
      'Chinese',
      name: 'chinese',
      desc: 'Name of the Chinese language',
      locale: localeName,
    );
  }

  String get spanish {
    return intl.Intl.message(
      'Spanish',
      name: 'spanish',
      desc: 'Name of the Spanish language',
      locale: localeName,
    );
  }

  String get german {
    return intl.Intl.message(
      'German',
      name: 'german',
      desc: 'Name of the German language',
      locale: localeName,
    );
  }

  String get turkish {
    return intl.Intl.message(
      'Turkish',
      name: 'turkish',
      desc: 'Name of the Turkish language',
      locale: localeName,
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale.toString()));
  }

  @override
  bool isSupported(Locale locale) {
    return ['en', 'it', 'ru', 'fr', 'es', 'de', 'tr', 'zh'].contains(locale.languageCode);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}