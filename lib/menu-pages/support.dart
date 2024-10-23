import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supporto SelmiGroup'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Come possiamo aiutarti?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            const Text(
              'Domande frequenti',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem('Come posso tracciare il mio ordine?'),
            _buildFAQItem('Quali sono i tempi di consegna?'),
            _buildFAQItem('Come posso effettuare un reso?'),
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
            'Questa è una risposta di esempio. Sostituisci questo testo con la risposta effettiva alla domanda.',
          ),
        ),
      ],
    );
  }
}