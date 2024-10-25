import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Data/product_model.dart';
import 'Data/products_data.dart';
import 'Components/language_selector.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;

  const ProductDetailsPage({super.key, required this.productName});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final ProductsData _productsData;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _productsData = ProductsData();
    _product = _productsData.getProduct(widget.productName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.locale; // Questo crea una dipendenza con la locale
    _updateProduct();
  }

  void _updateProduct() {
    setState(() {
      _productsData.refreshProducts();
      _product = _productsData.getProduct(widget.productName);
    });
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        body: Center(
          child: const Text('product_not_found').tr(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: Text(
          _product!.name,
          style: const TextStyle(
            fontFamily: 'SpaceAge',
            fontSize: 45,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: LanguageSelector(),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double availableHeight = constraints.maxHeight;
          final double imageHeight = availableHeight * 0.35;
          final double spacing = availableHeight * 0.02;

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
                  SizedBox(height: spacing * 5),
                  Text(
                    _product!.subtitle,
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing * 1.5),
                  Image.network(
                    _product!.imageUrl,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: spacing * 1.5),
                  Text(
                    _product!.year,
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
                    _product!.description,
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFFF8F9FA),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spacing * 1.5),
                  TextButton(
                    onPressed: () => _launchURL(_product!.pdfUrl),
                    child: Text(
                      ('download_pdf').tr(),
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFF8F9FA),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _launchURL(_product!.webPageUrl),
                    child: Text(
                      ('web_page').tr(),
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF8F9FA),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFF8F9FA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}