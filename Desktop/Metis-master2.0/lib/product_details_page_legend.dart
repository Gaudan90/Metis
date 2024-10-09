import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String scannedData;

  const ProductDetailsPage({Key? key, required this.scannedData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('LEGEND', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'TEMPERATRICE PROFESSIONALE\nCIOCCOLATO',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Center(
              child: Image.network(
                'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png', // Replace with actual image URL
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2024',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Capacità vasca: 35 kg'),
                  Text('Produzione oraria: 170 kg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    child: const Text('Scarica il pdf della scheda tecnica'),
                    onPressed: () {
                      // TODO: Implement PDF download
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Pagina web'),
                    onPressed: () {
                      // TODO: Implement web page navigation
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
