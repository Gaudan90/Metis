import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
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
          _buildOverlay(),
          Column(
            children: [
              Container(
                color: const Color(0xFF092d52).withOpacity(0.9),
                child: SafeArea(
                  bottom: false,
                  child: Header(
                    isFlashOn: isFlashOn,
                    onFlashToggle: _toggleFlash,
                    onMenuPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
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

  Widget _buildOverlay() {
    return Stack(
      children: [
        Container(
          color: const Color(0xFF092d52).withOpacity(0.9),
          height: MediaQuery.of(context).padding.top,
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcOut,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 300),
              Text(
                "AppLocalizations.of(context)!.scanQRCode",
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isDialogOpen && capture.barcodes.isNotEmpty) {
      final String scannedData = capture.barcodes.first.rawValue ?? 'No data';

      if (scannedData != 'http://www.google.com') {
        isDialogOpen = true;
        _showInvalidQRCodeDialog();
      } else {
        isDialogOpen = true;
        controller.stop();
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
  }

  void _showInvalidQRCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("AppLocalizations.of(context)!.invalidQRCode"),
          content: Text("AppLocalizations.of(context)!.invalidQRCodeMessage"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                isDialogOpen = false;
                controller.start();
                Navigator.of(context).pop();
              },
              child: Text("AppLocalizations.of(context)!.ok"),
            ),
          ],
        );
      },
    ).then((_) {
      isDialogOpen = false;
    });
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
