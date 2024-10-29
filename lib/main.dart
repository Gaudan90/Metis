import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'scanner_page.dart';
import 'menu-pages/login/auth_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SavedMachinesProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MainApp(),
      ),
    );
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ScanSelmi',
      debugShowCheckedModeBanner: false,
      home: QRScannerPage(),
    );
  }
}
