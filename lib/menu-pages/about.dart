import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who are we - SelmiGroup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SelmiGroup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'SelmiGroup is a leading provider of innovative technologies for the food industry. Founded in 1980, our mission is to provide state-of-the-art solutions to improve the efficiency and quality of food production.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Our services include:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Design and manufacture of machinery for the food industry'),
            _buildBulletPoint('Technical consulting and training'),
            _buildBulletPoint('After-sales service and maintenance'),
            _buildBulletPoint('Research and development of new technologies'),
            const SizedBox(height: 16),
            const Text(
              'Follow us on our social media:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildSocialLink(Icons.language, 'Web Page', 'https://www.selmigroup.com'),
            _buildSocialLink(Icons.facebook, 'Facebook', 'https://www.facebook.com/SelmiGroup'),
            _buildSocialLink(Icons.camera_alt, 'Instagram', 'https://www.instagram.com/selmigroup'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Implementare la navigazione all'URL
            },
            child: const Text('Visit'),
          ),
        ],
      ),
    );
  }
}