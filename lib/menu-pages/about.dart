import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            color: const Color(0xFF25344D),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Chi siamo - Selmi Group',
                        style: GoogleFonts.roboto(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selmi Group',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: const Color(0xFF25344D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Selmi Group è un\'azienda leader nel settore delle tecnologie innovative per l\'industria alimentare. Fondata nel 1980, la nostra missione è fornire soluzioni all\'avanguardia per migliorare l\'efficienza e la qualità della produzione alimentare.',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'I nostri servizi includono:',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBulletPoint(
                      'Progettazione e produzione di macchinari per l\'industria alimentare'),
                  _buildBulletPoint('Consulenza tecnica e formazione'),
                  _buildBulletPoint('Assistenza post-vendita e manutenzione'),
                  _buildBulletPoint('Ricerca e sviluppo di nuove tecnologie'),
                  const SizedBox(height: 32),
                  Text(
                    'Seguici sui social media:',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialLink(Icons.language, 'Sito web',
                      'https://www.selmi-group.it/'),
                  _buildSocialLink(Icons.facebook, 'Facebook',
                      'https://www.facebook.com/SelmiGroupChocolateMachinery'),
                  _buildSocialLink(Icons.camera_alt, 'Instagram',
                      'https://www.instagram.com/selmigroup'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF25344D),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: const Color(0xFF25344D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text, String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF25344D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: const Color(0xFF25344D)),
        title: Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xFF25344D),
          ),
        ),
        trailing: TextButton(
          onPressed: () {
            // Implement the URL navigation
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF25344D),
          ),
          child: Text(
            'Visita',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
