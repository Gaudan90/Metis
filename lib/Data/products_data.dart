import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'language_manager.dart';
import 'product_model.dart';
import 'package:easy_localization/easy_localization.dart';

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
      // ... altri prodotti ...
    };
    notifyListeners();
  }

  Product? getProduct(String productName) {
    return _products[productName.toUpperCase()];
  }
}