import 'package:flutter/material.dart';
import 'package:scanselmi/scanner_page.dart';
import 'password_recovery_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAdmin = false;
  String _errorMessage = '';

  void _handleSignIn() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Is Admin: $_isAdmin');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Welcome'),
          content: Text('Welcome, ${_emailController.text}!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sfondo_log_in.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
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
                  SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(text: 'Sign in to '),
                        TextSpan(
                            text: 'ScanSelmi',
                            style: TextStyle(color: Color(0xFF304A78))),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _isAdmin,
                        onChanged: (value) {
                          setState(() {
                            _isAdmin = value!;
                          });
                        },
                      ),
                      Text("I'm an admin"),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Sign in'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF304A78),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: _handleSignIn,
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Color(0xFF304A78)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordRecoveryPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Return Home',
                      style: TextStyle(color: Color(0xFF304A78)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRScannerPage()),
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
