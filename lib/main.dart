import 'package:flutter/material.dart';

import 'login_selmi.dart';

//main
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScanSelmi',
      theme: ThemeData(
        primaryColor: Color(0xFF304A78),
        scaffoldBackgroundColor: Color(0xFF304A78),
        fontFamily: 'Roboto',  // Assicurati di aver configurato questo font nel pubspec.yaml
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,  // Rimuove il banner di debug
    );
  }
}


