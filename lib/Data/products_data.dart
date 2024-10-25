import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'product_model.dart';

class ProductsData extends ChangeNotifier {
  ProductsData._internal() {
    refreshProducts();
  }

  static final ProductsData _instance = ProductsData._internal();
  late Map<String, Product> _products;

  factory ProductsData() {
    return _instance;
  }

  Map<String, Product> get products => _products;

  void refreshProducts() {
    _products = {
      'LEGEND': Product(
        name: 'LEGEND',
        subtitle: 'products.legend.subtitle'.tr(),
        imageUrl:
            'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
        description: 'products.legend.description'.tr(),
        pdfUrl:
            'https://www.selmi-group.it/pdf/Legend-Temperatrice-professionale-cioccolato.pdf',
        webPageUrl:
            'https://www.selmi-group.it/temperatrice-professionale-cioccolato-legend.html',
        year: '2024',
      ),
      'TRUFFLE': Product(
        name: 'TRUFFLE',
        subtitle: 'products.truffle.subtitle'.tr(),
        imageUrl:
            'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
        description: 'products.truffle.description'.tr(),
        pdfUrl:
            'https://www.selmi-group.it/pdf/Truffle-Nastro-ricopritore-per-tartufi-in-cioccolato.pdf',
        webPageUrl:
            'https://www.selmi-group.it/nastro-ricopritore-cioccolato-truffle.html',
        year: '2023',
      ),
      'SELMI ONE': Product(
        name: 'SELMI ONE',
        subtitle: 'products.selmi_one.subtitle'.tr(),
        imageUrl:
            'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/selmi-one-temperatrice-cioccolato/selmi-one-temperatrice-cioccolato-p.png',
        description: 'products.selmi_one.description'.tr(),
        pdfUrl:
            'https://www.selmi-group.it/pdf/Selmi-One-Temperatrice-professionale-cioccolato.pdf',
        webPageUrl:
            'https://www.selmi-group.it/temperatrice-professionale-cioccolato-selmione.html',
      ),
    };
    notifyListeners();
  }

  Product? getProduct(String productName) {
    return _products[productName.toUpperCase()];
  }
}
