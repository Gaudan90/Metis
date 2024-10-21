import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'product_details_page.dart';
import 'package:scanselmi/Components/bottom_sheet.dart';
import 'package:scanselmi/Components/header.dart';
import 'Components/custom_drawer.dart';
import 'app_language.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin {
  late MobileScannerController controller;
  bool isDialogOpen = false;
  bool isFlashOn = false;
  late AnimationController dragController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  void _openLanguageMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () => _changeLanguage(const Locale('en')),
              ),
              ListTile(
                title: const Text('Italiano'),
                onTap: () => _changeLanguage(const Locale('it')),
              ),
              ListTile(
                title: const Text('Français'),
                onTap: () => _changeLanguage(const Locale('fr')),
              ),
              ListTile(
                title: const Text('Español'),
                onTap: () => _changeLanguage(const Locale('es')),
              ),
              ListTile(
                title: const Text('Deutsch'),
                onTap: () => _changeLanguage(const Locale('de')),
              ),
              ListTile(
                title: const Text('Türkçe'),
                onTap: () => _changeLanguage(const Locale('tr')),
              ),
              ListTile(
                title: const Text('Русский'),
                onTap: () => _changeLanguage(const Locale('ru')),
              ),
              ListTile(
                title: const Text('中文'),
                onTap: () => _changeLanguage(const Locale('zh')),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(Locale newLocale) {
    AppLanguage.of(context).changeLanguage(newLocale);
    Navigator.of(context).pop(); // Close the language selection dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(onSettingsTap: _openLanguageMenu),
      drawerEnableOpenDragGesture: true,
      drawerScrimColor: Colors.black54,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),
          Column(
            children: [
              Header(
                isFlashOn: isFlashOn,
                onFlashToggle: _toggleFlash,
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const Spacer(),
              BottomSheett(
                dragController: dragController,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isDialogOpen && capture.barcodes.isNotEmpty) {
      isDialogOpen = true;
      controller.stop();
      final String scannedData = capture.barcodes.first.rawValue ?? 'No data';
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(productName: scannedData),
        ),
      )
          .then((_) {
        isDialogOpen = false;
        controller.start();
      });
    }
  }

  void _toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      controller.toggleTorch();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    dragController.dispose();
    super.dispose();
  }
}
