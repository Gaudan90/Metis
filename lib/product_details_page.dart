import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productName;

  const ProductDetailsPage({Key? key, required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = productName.toUpperCase();
    final String subtitle = _getSubtitle(productName);
    final String imageUrl = _getImageUrl(productName);
    final String year = '2024';
    final String capacity = 'Capacità vasca: 35 kg';
    final String production = 'Produzione oraria: 170 kg';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            const Color(0xFFF8F9FA), // Set to the top half gradient color
        elevation: 0,
        centerTitle: true, // Center the title
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'SpaceAge',
            fontSize: 45,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar:
          true, // Content extends behind AppBar for the full background effect
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double availableHeight = constraints.maxHeight;
          final double imageHeight =
              availableHeight * 0.35; // Make image bigger but fit screen
          final double spacing = availableHeight * 0.02; // Dynamic spacing

          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8F9FA), Color(0xFF25344D)],
                stops: [0.5, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: spacing * 5), // Add some space below the AppBar
                  Text(
                    subtitle,
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300, // Thinner font weight
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing * 1.5),
                  Image.network(
                    imageUrl,
                    height: imageHeight, // Adjusted image height to fit screen
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: spacing * 1.5),
                  Text(
                    year,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF8F9FA),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 0.5),
                  Text(
                    capacity,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFF8F9FA), // Changed to #F8F9FA
                      ),
                    ),
                  ),
                  Text(
                    production,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFF8F9FA), // Changed to #F8F9FA
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 1.5),
                  TextButton(
                    child: Text(
                      'Scarica il pdf della scheda tecnica',
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(
                              0xFFF8F9FA), // Underline color set to #F8F9FA
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement PDF download
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Pagina web',
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(
                              0xFFF8F9FA), // Underline color set to #F8F9FA
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement web page navigation
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getSubtitle(String productName) {
    switch (productName.toUpperCase()) {
      case 'LEGEND':
        return 'TEMPERATRICE PROFESSIONALE\nCIOCCOLATO';
      case 'TRUFFLE':
        return 'Nastro per la ricopertura \ncon cioccolato';
      default:
        return 'Descrizione prodotto';
    }
  }

  String _getImageUrl(String productName) {
    switch (productName.toUpperCase()) {
      case 'LEGEND':
        return 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png';
      case 'TRUFFLE':
        return 'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png';
      default:
        return 'https://via.placeholder.com/300'; // Placeholder image if product is unknown
    }
  }
}
