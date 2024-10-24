import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
                        'Who are we - Selmi Group',
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
                    'SelmiGroup is a leading provider of innovative technologies for the food industry. Founded in 1980, our mission is to provide state-of-the-art solutions to improve the efficiency and quality of food production.',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Our services include:',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBulletPoint(
                      'Design and manufacture of machinery for the food industry'),
                  _buildBulletPoint('Technical consulting and training'),
                  _buildBulletPoint('After-sales service and maintenance'),
                  _buildBulletPoint(
                      'Research and development of new technologies'),
                  const SizedBox(height: 32),
                  Text(
                    'Follow us on our social media:',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF25344D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialLink(
                      Icons.language, 'Website', 'https://www.selmi-group.it/'),
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
            'Visit',
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
