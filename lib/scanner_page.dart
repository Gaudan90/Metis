import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details_page.dart';
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
              const SizedBox(
                  height: 300), // Adjust this value to position the text
              Text(
                "Scan your machine's QR code",
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
