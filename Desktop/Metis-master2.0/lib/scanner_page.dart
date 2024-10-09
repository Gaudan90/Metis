import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'product_details_page_legend.dart';
import 'package:scanselmi/Components/bottom_sheet.dart';
import 'package:scanselmi/Components/header.dart';
import 'Components/custom_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
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
          builder: (context) => ProductDetailsPage(scannedData: scannedData),
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
