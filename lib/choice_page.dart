import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Data/products_data.dart';
import 'Data/product_model.dart';
import 'product_details_page.dart';

class ChoicePage extends StatefulWidget {
  final String productName;

  const ChoicePage({
    Key? key,
    required this.productName,
  }) : super(key: key);

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  late Product? product;
  String selectedLanguage = "English";
  String selectedYear = "2024";

  final List<String> availableLanguages = [
    "English",
    "Italiano",
    "中文",
    "Türkçe",
    "Français",
    "Español",
    "Deutsch",
    "Русский",
  ];

  final List<String> availableYears = ["2024", "2023", "2022", "2021", "2020"];

  @override
  void initState() {
    super.initState();
    product = ProductsData.getProduct(widget.productName);
    // Se il prodotto ha un anno specifico, lo impostiamo come default
    if (product?.year != null) {
      selectedYear = product!.year;
    }
  }

  @override
  void didUpdateWidget(ChoicePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productName != widget.productName) {
      setState(() {
        product = ProductsData.getProduct(widget.productName);
        if (product?.year != null) {
          selectedYear = product!.year;
        }
      });
    }
  }

  Widget _buildDropdownMenu(
    String title,
    List<String> items,
    String selectedItem,
    void Function(String?) onChanged,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              title,
              style: GoogleFonts.dosis(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF25344D),
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: onChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              border: InputBorder.none,
            ),
            dropdownColor: Colors.white,
            style: GoogleFonts.dosis(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (product != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(
            productName: widget.productName,
            language: selectedLanguage,
            year: selectedYear,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 0.8,
        title: Text(
          product?.name ?? 'Product Not Found',
          style: const TextStyle(
            fontFamily: 'SpaceAge',
            fontSize: 35,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: product == null
          ? const Center(child: Text('Product not found'))
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF8F9FA), Color(0xFF25344D)],
                  stops: [0.5, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        const Spacer(flex: 1),
                        Text(
                          product?.subtitle ?? '',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(flex: 1),
                        SizedBox(
                          height: constraints.maxHeight * 0.3,
                          child: Image.network(
                            product?.imageUrl ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Spacer(flex: 1),
                        SizedBox(
                          height: constraints.maxHeight * 0.12,
                          child: _buildDropdownMenu(
                            "Select Language",
                            availableLanguages,
                            selectedLanguage,
                            (value) {
                              setState(() => selectedLanguage = value!);
                            },
                          ),
                        ),
                        const Spacer(flex: 1),
                        SizedBox(
                          height: constraints.maxHeight * 0.12,
                          child: _buildDropdownMenu(
                            "Select Year",
                            availableYears,
                            selectedYear,
                            (value) {
                              setState(() => selectedYear = value!);
                            },
                          ),
                        ),
                        const Spacer(flex: 1),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: constraints.maxHeight * 0.08,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                            onPressed: _onSubmit,
                            child: Text(
                              "Continue",
                              style: GoogleFonts.dosis(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
