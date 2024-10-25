import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'Data/language_manager.dart';
import 'scanner_page.dart';
import 'auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageManager()),
          ChangeNotifierProvider(create: (_) => SavedMachinesProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: EasyLocalization(
          supportedLocales: const [
          Locale('en'), // Inglese
            Locale('it'), // Italiano
            Locale('fr'), // Francese
            Locale('de'), // Tedesco
            Locale('es'), // Spagnolo
            Locale('ru'), // Russo
            Locale('tr'), // Turco
            Locale('zh'),
          ],
          path: 'lib/assets/translations',
          fallbackLocale: const Locale('en'),
          startLocale: const Locale('en'),
          child: const MainApp(),
        ),
      )
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScanSelmi',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const QRScannerPage(),
    );
  }
}