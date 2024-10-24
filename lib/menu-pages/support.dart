import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

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
                        'SelmiGroup Support',
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
                    'How can we help you?',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: const Color(0xFF25344D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 32),
                  Text(
                    'FAQ',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: const Color(0xFF25344D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFAQItem('How can I track my order?'),
                  _buildFAQItem('What are the delivery times?'),
                  _buildFAQItem('How can I file a return?'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF25344D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF25344D).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF25344D)),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF25344D),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: const Color(0xFF25344D),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Color(0xFF25344D)),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF25344D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xFF25344D),
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: const Color(0xFF25344D),
        collapsedIconColor: const Color(0xFF25344D),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'This is a sample. Replace this text with the actual answer to the question.',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF25344D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
