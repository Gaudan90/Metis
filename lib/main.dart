import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'scanner_page.dart';
import 'app_language.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLanguage(
      locale: _locale,
      changeLanguage: _changeLanguage,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'QR Scanner App',
            theme: ThemeData(
              primaryColor: const Color(0xFF092d52),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: AppLanguage.of(context).locale,
            home: const QRScannerPage(),
          );
        },
      ),
    );
  }
}