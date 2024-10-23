import 'product_model.dart';

class ProductsData {
  static const Map<String, Product> products = {
    'LEGEND': Product(
      name: 'LEGEND',
      subtitle: 'Temperatrice professionale cioccolato',
      imageUrl:
          'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
      description: 'Capacità vasca: 24 kg\nProduzione oraria: 90 kg',
      pdfUrl:
          'https://www.selmi-group.it/pdf/Legend-Temperatrice-professionale-cioccolato.pdf',
      webPageUrl:
          'https://www.selmi-group.it/temperatrice-professionale-cioccolato-legend.html',
    ),
    'TRUFFLE': Product(
      name: 'TRUFFLE',
      subtitle: 'Nastro ricopritore per tartufi in cioccolato',
      imageUrl:
          'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
      description: 'Nastro per la ricopertura con cioccolato',
      pdfUrl:
          'https://www.selmi-group.it/pdf/Truffle-Nastro-ricopritore-per-tartufi-in-cioccolato.pdf',
      webPageUrl:
          'https://www.selmi-group.it/nastro-ricopritore-cioccolato-truffle.html',
      year: '2023',
    ),
    'SELMI ONE': Product(
      name: 'SELMI ONE',
      subtitle: 'Temperatrice professionale cioccolato',
      imageUrl:
          'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato-p.png',
      description: 'Capacità vasca: 12 kg\nProduzione oraria: 55 kg',
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
