import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productName;

  const ProductDetailsPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String title = productName.toUpperCase();
    final String subtitle = _getSubtitle(context, productName);
    final String imageUrl = _getImageUrl(productName);
    final String year = l10n.productYear('2024');
    final String capacity = l10n.tankCapacity('35');
    final String production = l10n.hourlyProduction('170');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'SpaceAge',
              fontSize: 45,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double availableHeight = constraints.maxHeight;
          final double imageHeight = availableHeight * 0.35;
          final double spacing = availableHeight * 0.02;

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF8F9FA), Color(0xFF25344D)],
                  stops: [0.5, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: spacing * 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      subtitle,
                      style: GoogleFonts.bebasNeue(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: spacing * 1.5),
                  Image.network(
                    imageUrl,
                    height: imageHeight,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      capacity,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      production,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: spacing * 1.5),
                  TextButton(
                    child: Text(
                      l10n.downloadTechnicalSheet,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFF8F9FA),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      // TODO: Implement PDF download
                    },
                  ),
                  TextButton(
                    child: Text(
                      l10n.webPage,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFF8F9FA),
                        ),
                      ),
                      textAlign: TextAlign.center,
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

  String _getSubtitle(BuildContext context, String productName) {
    final l10n = AppLocalizations.of(context)!;
    switch (productName.toUpperCase()) {
      case 'LEGEND':
        return l10n.legendSubtitle;
      case 'TRUFFLE':
        return l10n.truffleSubtitle;
      default:
        return l10n.defaultProductDescription;
    }
  }

  String _getImageUrl(String productName) {
    switch (productName.toUpperCase()) {
      case 'LEGEND':
        return 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png';
      case 'TRUFFLE':
        return 'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png';
      default:
        return 'https://via.placeholder.com/300';
    }
  }
}
