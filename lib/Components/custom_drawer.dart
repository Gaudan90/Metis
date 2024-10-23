import 'package:flutter/material.dart';
import 'package:scanselmi/login_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
//
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              //TODO: It should be something like this, the settings_page.dart should have a widget called LoginPage(),
              //When it's ready, remove these comments
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },

              child:const DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF092d52),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          color: Color(0xFF092d52), size: 40),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Languages'),
              onTap: () {
                Navigator.pop(context);
                /*
                
                //TODO: It should be something like this, the settings_page.dart should have a widget called LanguagesPage(),
                //When it's ready, remove these comments

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LanguagesPage()),
                );

                */
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
