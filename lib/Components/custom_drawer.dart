import 'package:flutter/material.dart';
/*import 'package:flutter_application_1/menu-pages/language.dart';*/
import 'package:flutter_application_1/menu-pages/support.dart';
import 'package:flutter_application_1/menu-pages/about.dart';
import 'package:flutter_application_1/menu-pages/feedback.dart';
import 'package:provider/provider.dart';
import '../menu-pages/login/auth_state.dart';
import '../menu-pages/login/login.dart';
import '../menu-pages/machine_list.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(onTap: () {
              Navigator.pop(context); // Chiude il drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }, child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF092d52),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: authProvider.isAuthenticated
                            ? const Icon(Icons.person,
                                color: Color(0xFF092d52), size: 40)
                            : const Icon(Icons.login,
                                color: Color(0xFF092d52), size: 40),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        authProvider.isAuthenticated ? 'Admin' : 'Login',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
            /*
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LanguagePage()),
                );
              },
            ), */
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SupportPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Machine List'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MachineList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
