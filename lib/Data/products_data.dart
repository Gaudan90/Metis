import 'product_model.dart';

class ProductsData {
  static const Map<String, Product> products = {
    'LEGEND': Product(
      name: 'LEGEND',
      subtitle: 'Professional chocolate tempering machine',
      imageUrl: 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
      description: 'Tank capacity: 24 kg\nProduction per hour: 90 kg',
      pdfUrl: 'https://www.selmi-group.it/pdf/Legend-Temperatrice-professionale-cioccolato.pdf',
      webPageUrl: 'https://www.selmi-group.it/temperatrice-professionale-cioccolato-legend.html',
    ),
    'TRUFFLE': Product(
      name: 'TRUFFLE',
      subtitle: 'Chocolate truffle coating tape',
      imageUrl: 'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
      description: 'Chocolate enrobing tape',
      pdfUrl: 'https://www.selmi-group.it/pdf/Truffle-Nastro-ricopritore-per-tartufi-in-cioccolato.pdf',
      webPageUrl: 'https://www.selmi-group.it/nastro-ricopritore-cioccolato-truffle.html',
      year: '2023',
    ),
    'SELMI ONE': Product(
      name: 'SELMI ONE',
      subtitle: 'Professional chocolate tempering machine',
      imageUrl: 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato-p.png',
      description: 'Tank capacity: 12 kg\nProduction per hour: 55 kg',
      pdfUrl: 'https://www.selmi-group.it/pdf/Selmi-One-Temperatrice-professionale-cioccolato.pdf',
      webPageUrl: 'https://www.selmi-group.it/temperatrice-professionale-cioccolato-selmione.html',
    ),
    'COLOR EX': Product(
      name: 'COLOR EX',
      subtitle: 'Advanced tempering machine with color mixing capabilities',
      imageUrl: '/api/placeholder/100/100',
      description: 'A state-of-the-art machine for chocolate tempering and color mixing.',
      pdfUrl: '/api/placeholder/pdf/color_ex.pdf',
      webPageUrl: '/api/placeholder/web/color_ex.html',
    ),
    'PLUS EX': Product(
      name: 'PLUS EX',
      subtitle: 'Upgraded tempering technology for consistent results',
      imageUrl: '/api/placeholder/100/100',
      description: 'An enhanced tempering machine ensuring superior chocolate quality.',
      pdfUrl: '/api/placeholder/pdf/plus_ex.pdf',
      webPageUrl: '/api/placeholder/web/plus_ex.html',
    ),
    'FUTURA EX': Product(
      name: 'FUTURA EX',
      subtitle: 'Future-oriented tempering machine designed for high efficiency',
      imageUrl: '/api/placeholder/100/100',
      description: 'A cutting-edge tempering machine for professional chocolatiers.',
      pdfUrl: '/api/placeholder/pdf/futura_ex.pdf',
      webPageUrl: '/api/placeholder/web/futura_ex.html',
    ),
    'TOP EX': Product(
      name: 'TOP EX',
      subtitle: 'Top-tier tempering machine for professional chocolatiers',
      imageUrl: '/api/placeholder/100/100',
      description: 'A premier machine for chocolate tempering.',
      pdfUrl: '/api/placeholder/pdf/top_ex.pdf',
      webPageUrl: '/api/placeholder/web/top_ex.html',
    ),
    'CENTO': Product(
      name: 'CENTO',
      subtitle: 'Precision tempering for high-quality chocolate production',
      imageUrl: '/api/placeholder/100/100',
      description: 'A precise machine for consistent chocolate tempering.',
      pdfUrl: '/api/placeholder/pdf/cento.pdf',
      webPageUrl: '/api/placeholder/web/cento.html',
    ),
    'AUTOMATIC TRUFFLE': Product(
      name: 'AUTOMATIC TRUFFLE',
      subtitle: 'Fully automatic truffle coating machine',
      imageUrl: '/api/placeholder/100/100',
      description: 'High-efficiency coating machine for chocolate truffles.',
      pdfUrl: '/api/placeholder/pdf/automatic_truffle.pdf',
      webPageUrl: '/api/placeholder/web/automatic_truffle.html',
    ),
    'R200 LEGEND': Product(
      name: 'R200 LEGEND',
      subtitle: 'Reliable coating machine for various chocolate products',
      imageUrl: '/api/placeholder/100/100',
      description: 'A versatile machine for chocolate coating.',
      pdfUrl: '/api/placeholder/pdf/r200_legend.pdf',
      webPageUrl: '/api/placeholder/web/r200_legend.html',
    ),
    'RS200': Product(
      name: 'RS200',
      subtitle: 'Specialized machine for even coating applications',
      imageUrl: '/api/placeholder/100/100',
      description: 'Designed for efficient chocolate coating.',
      pdfUrl: '/api/placeholder/pdf/rs200.pdf',
      webPageUrl: '/api/placeholder/web/rs200.html',
    ),
    'MOULD LOADER 175': Product(
      name: 'MOULD LOADER 175',
      subtitle: 'Efficient loader for chocolate molds',
      imageUrl: '/api/placeholder/100/100',
      description: 'Automated loader for precise chocolate molding.',
      pdfUrl: '/api/placeholder/pdf/mould_loader_175.pdf',
      webPageUrl: '/api/placeholder/web/mould_loader_175.html',
    ),
    'MOULDING LINE 275': Product(
      name: 'MOULDING LINE 275',
      subtitle: 'Complete molding line for high production rates',
      imageUrl: '/api/placeholder/100/100',
      description: 'High-capacity line for molding chocolate products.',
      pdfUrl: '/api/placeholder/pdf/moulding_line_275.pdf',
      webPageUrl: '/api/placeholder/web/moulding_line_275.html',
    ),
    'GALILEO': Product(
      name: 'GALILEO',
      subtitle: 'Advanced molding technology for unique designs',
      imageUrl: '/api/placeholder/100/100',
      description: 'Specialized for creating intricate chocolate designs.',
      pdfUrl: '/api/placeholder/pdf/galileo.pdf',
      webPageUrl: '/api/placeholder/web/galileo.html',
    ),
    // Add more products here as needed
  };

  static Product? getProduct(String productName) {
    return products[productName.toUpperCase()];
  }
}
