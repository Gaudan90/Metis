import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi siamo - SelmiGroup'),
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
              'SelmiGroup è un\'azienda leader nel settore delle tecnologie innovative per l\'industria alimentare. Fondata nel 1980, la nostra missione è fornire soluzioni all\'avanguardia per migliorare l\'efficienza e la qualità della produzione alimentare.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'I nostri servizi includono:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('Progettazione e produzione di macchinari per l\'industria alimentare'),
            _buildBulletPoint('Consulenza tecnica e formazione'),
            _buildBulletPoint('Assistenza post-vendita e manutenzione'),
            _buildBulletPoint('Ricerca e sviluppo di nuove tecnologie'),
            const SizedBox(height: 16),
            const Text(
              'Seguici sui social media:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildSocialLink(Icons.language, 'Sito web', 'https://www.selmigroup.com'),
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
            child: const Text('Visita'),
          ),
        ],
      ),
    );
  }
}