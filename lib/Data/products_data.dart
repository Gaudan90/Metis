import 'product_model.dart';

class ProductsData {
  static const Map<String, Product> products = {
    'LEGEND': Product(
      name: 'LEGEND',
      subtitle: 'Professional chocolate tempering machine',
      imageUrl:
          'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
      description: 'Tank capacity: 24 kg\nProduction per hour: 90 kg',
      pdfUrl:
          'https://www.selmi-group.it/pdf/Legend-Temperatrice-professionale-cioccolato.pdf',
      webPageUrl:
          'https://www.selmi-group.it/temperatrice-professionale-cioccolato-legend.html',
    ),
    'TRUFFLE': Product(
      name: 'TRUFFLE',
      subtitle: 'Chocolate truffle coating tape',
      imageUrl:
          'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
      description: 'Chocolate enrobing tape',
      pdfUrl:
          'https://www.selmi-group.it/pdf/Truffle-Nastro-ricopritore-per-tartufi-in-cioccolato.pdf',
      webPageUrl:
          'https://www.selmi-group.it/nastro-ricopritore-cioccolato-truffle.html',
      year: '2023',
    ),
    'SELMI ONE': Product(
      name: 'SELMI ONE',
      subtitle: 'Professional chocolate tempering machine',
      imageUrl:
          'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato-p.png',
      description: 'Tank capacity: 12 kg\nProduction per hour: 55 kg',
      pdfUrl:
          'https://www.selmi-group.it/pdf/Selmi-One-Temperatrice-professionale-cioccolato.pdf',
      webPageUrl:
          'https://www.selmi-group.it/temperatrice-professionale-cioccolato-selmione.html',
    ),
  };

  static Product? getProduct(String productName) {
    return products[productName.toUpperCase()];
  }
}
