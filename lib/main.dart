import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'scanner_page.dart';
import 'menu-pages/login/auth_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SavedMachinesProvider()),
        ChangeNotifierProvider(create: (_) => AuthState()),
        // Qui puoi aggiungere altri provider se necessario in futuro
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ScanSelmi',
      debugShowCheckedModeBanner: false,  // Rimuove il banner debug
      home: QRScannerPage(),
    );
  }
}