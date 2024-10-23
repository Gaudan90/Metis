import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'package:provider/provider.dart';
import 'scanner_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SavedMachinesProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRScannerPage(),
    );
  }
}
