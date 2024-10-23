import 'package:flutter/material.dart';
import 'package:flutter_application_1/product_details_page.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_application_1/choice_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChoicePage(),
    );
  }
}

class ChoicePage extends StatefulWidget {
  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  String ChoiceTheLanguage = "Italiano";
  String ChoiceTheYear = "2024";

  final List<String> languages = [
    "Italiano",
    "English",
    "中国人",
    "Türkçe",
    "Français",
    "Español",
    "Deutsch",
    "Русский",
  ];
  final List<String> years = ["2024", "2023", "2022", "2021", "2020"];

  final String productImageUrl = "https://i.ibb.co/GQ4Tchn/selmi-one-temperatrice-cioccolato.png";
  final String logoImageUrl = "https://www.selmi-group.it/img/logo-selmi-social.png";

  Widget buildProductImage(BuildContext context, double containerHeight) {
    // Calcola l'altezza dell'immagine come 80% dell'altezza del container
    final imageHeight = containerHeight * 0.7;

    return Image.network(
      productImageUrl,
      height: imageHeight,
      width: MediaQuery.of(context).size.width * 0.6, // Aumentato a 60% della larghezza
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        print('Errore caricamento immagine: $error');
        return Container(
          height: imageHeight,
          width: MediaQuery.of(context).size.width * 0.6,
          color: Colors.grey[300],
          child: Icon(Icons.image_not_supported, size: 50),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Container(
            height: 40,
            child: Image.network(
              logoImageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.business, size: 30);
              },
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Calcola l'altezza disponibile per il contenuto
            final availableHeight = constraints.maxHeight;
            // Altezza per la sezione delle scelte (30% dell'altezza totale)
            final choicesHeight = availableHeight * 0.3;

            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  // Sfondo diviso
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(color: Colors.white),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(color: Color(0xFF25334D)),
                      ),
                    ],
                  ),
                  // Layout principale
                  Column(
                    children: [
                      // Spazio per l'immagine (70% dell'altezza)
                      Container(
                        height: availableHeight - choicesHeight,
                        child: Center(
                          child: buildProductImage(context, availableHeight - choicesHeight),
                        ),
                      ),
                      // Sezione scelte (30% dell'altezza)
                      Container(
                        height: choicesHeight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildMarkDownMenu(
                              "Language",
                              languages,
                              ChoiceTheLanguage,
                                  (value) {
                                setState(() => ChoiceTheLanguage = value!);
                              },
                              Colors.white,
                            ),
                            SizedBox(height: 10), // Spazio tra le scelte
                            buildMarkDownMenu(
                              "Years",
                              years,
                              ChoiceTheYear,
                                  (value) {
                                setState(() => ChoiceTheYear = value!);
                              },
                              Colors.white,
                            ),
                            SizedBox(height: 20), // Spazio tra i menu e il bottone
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () {
                                //Lore questo è il bottone che deve avere tutte le logiche
                              },
                              child: Text(
                                "Invio",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10), // Spazio tra il bottone e il fondo
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildMarkDownMenu(
      String title,
      List<String> items,
      String selectedItem,
      void Function(String?) onChanged,
      Color dropdownColor,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: dropdownColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedItem,
        onChanged: onChanged,
        dropdownColor: dropdownColor,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: MarkdownBody(data: item),
          );
        }).toList(),
        hint: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget buildMarkDownMenu(
      String title,
      List<String> items,
      String selectedItem,
      void Function(String?) onChanged,
      Color dropdownColor,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: dropdownColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedItem,
        onChanged: onChanged,
        dropdownColor: dropdownColor,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: MarkdownBody(data: item),
          );
        }).toList(),
        hint: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
