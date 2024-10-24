import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelmiGroup Support'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSupportOption(
              icon: Icons.phone,
              title: 'Call us',
              subtitle: '+39 123 456 7890',
              onTap: () {
                // Implementa la funzionalità di chiamata
              },
            ),
            _buildSupportOption(
              icon: Icons.email,
              title: 'Send us an email',
              subtitle: 'supporto@selmigroup.com',
              onTap: () {
                // Implementa la funzionalità di invio email
              },
            ),
            _buildSupportOption(
              icon: Icons.chat,
              title: 'Live chat',
              subtitle: 'Availability 9:00 - 18:00',
              onTap: () {
                // Implementa la funzionalità di chat dal vivo
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'FAQ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem('How can I track my order?'),
            _buildFAQItem('What are the delivery times?'),
            _buildFAQItem('How can I file a return?'),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return ExpansionTile(
      title: Text(question),
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'This is a sample. Replace this text with the actual answer to the question.',
          ),
        ),
      ],
    );
  }
}