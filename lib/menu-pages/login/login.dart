import 'package:flutter/material.dart';
import 'package:flutter_application_1/menu-pages/login/password_recovery.dart';
import 'package:flutter_application_1/scanner_page.dart';

class LoginPage extends StatefulWidget {
  final String message = "admin";

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _handleSignIn() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Inserisci email e password';
      });
    } else if (email == 'admin@gmail.com' && password == '123!') {
      setState(() {
        _errorMessage = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      );
    } else {
      setState(() {
        _errorMessage = 'La password o l\'email potrebbero essere sbagliati';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://www.selmi-group.it/img/logo-selmi-social.png',
                    width: 80,
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(text: 'Accedi a '),
                        TextSpan(
                            text: 'ScanSelmi',
                            style: TextStyle(color: Color(0xFF304A78))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Indirizzo email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF304A78),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    onPressed: _handleSignIn,
                    child: Text('Accedi'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    child: const Text(
                      'Password dimenticata?',
                      style: TextStyle(color: Color(0xFF304A78)),
                    ),
                    onPressed: () {
                      // Aggiungi la navigazione alla pagina di recupero password qui
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordRecoveryPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Torna alla Home',
                      style: TextStyle(color: Color(0xFF304A78)),
                    ),
                    onPressed: () {
                      // Navigazione verso la home page o un'altra pagina se necessario
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRScannerPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}