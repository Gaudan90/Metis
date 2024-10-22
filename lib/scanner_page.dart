import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'product_details_page.dart';
import 'package:flutter_application_1/Components/bottom_sheet.dart';
import 'package:flutter_application_1/Components/header.dart';
import 'Components/custom_drawer.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin {
  late MobileScannerController _controller;
  bool _isDialogOpen = false;
  bool _isFlashOn = false;
  late AnimationController _dragController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
        // Add any configuration options here
        );
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dragController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCamera();
    });
  }

  void _startCamera() {
    if (!_isDialogOpen) {
      _controller.start();
    }
  }

  void _stopCamera() {
    _controller.stop();
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
            controller: _controller,
            onDetect: _onDetect,
          ),
          Column(
            children: [
              Header(
                isFlashOn: _isFlashOn,
                onFlashToggle: _toggleFlash,
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const Spacer(),
              BottomSheett(
                dragController: _dragController,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (!_isDialogOpen && capture.barcodes.isNotEmpty) {
      _isDialogOpen = true;
      _stopCamera();
      try {
        final String scannedData = capture.barcodes.first.rawValue ?? 'No data';
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
                productName: scannedData), // Updated to use productName
          ),
        )
            .then((_) {
          _isDialogOpen = false;
          _startCamera();
        });
      } catch (e) {
        // Handle any exceptions here
        _isDialogOpen = false;
        _startCamera();
      }
    }
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller.toggleTorch();
    });
  }
}
