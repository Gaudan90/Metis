import 'package:flutter/material.dart';
import 'scanner_page.dart';
import 'choice_page.dart';


void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRScannerPage(),  // Cambiato da QRScannerPage a ChoicePage
    );
  }
}