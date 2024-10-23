import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

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
                        'Supporto SelmiGroup',
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
            child: Stack(
              children: [
                // Background diviso
                Column(
                  children: [
                    Expanded(child: Container(color: Colors.white)),
                    Expanded(child: Container(color: const Color(0xFF25344D))),
                  ],
                ),
                // Contenuto
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Come possiamo aiutarti?',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: const Color(0xFF25344D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSupportOption(
                        icon: Icons.phone,
                        title: 'Chiamaci',
                        subtitle: '+39 123 456 7890',
                        onTap: () {
                          // Implementa la funzionalità di chiamata
                        },
                      ),
                      _buildSupportOption(
                        icon: Icons.email,
                        title: 'Inviaci un\'email',
                        subtitle: 'supporto@selmigroup.com',
                        onTap: () {
                          // Implementa la funzionalità di invio email
                        },
                      ),
                      _buildSupportOption(
                        icon: Icons.chat,
                        title: 'Chat dal vivo',
                        subtitle: 'Disponibile 9:00 - 18:00',
                        onTap: () {
                          // Implementa la funzionalità di chat dal vivo
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Domande frequenti',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildFAQItem('Come posso tracciare il mio ordine?'),
                      _buildFAQItem('Quali sono i tempi di consegna?'),
                      _buildFAQItem('Come posso effettuare un reso?'),
                    ],
                  ),
                ),
              ],
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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
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
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFF25344D)
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Questa è una risposta di esempio. Sostituisci questo testo con la risposta effettiva alla domanda.',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
