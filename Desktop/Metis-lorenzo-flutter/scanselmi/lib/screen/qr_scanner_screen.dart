import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../widgets/scanner_header.dart';
import '../widgets/bottom_sheet.dart';
import 'product_details_page.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  late MobileScannerController controller;
  bool isDialogOpen = false;
  bool isFlashOn = false;
  late AnimationController dragController;

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
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: _handleScan,
        ),
        Column(
          children: [
            ScannerHeader(
              isFlashOn: isFlashOn,
              onFlashPressed: _toggleFlash,
            ),
            const Spacer(),
            DraggableBottomSheet(
              dragController: dragController,
            ),
          ],
        ),
      ],
    );
  }

  void _handleScan(BarcodeCapture capture) {
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
