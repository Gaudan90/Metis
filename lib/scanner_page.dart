import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Data/products_data.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'product_details_page.dart';
import 'package:flutter_application_1/Components/bottom_sheet.dart';
import 'package:flutter_application_1/Components/header.dart';
import 'Components/custom_drawer.dart';

class QRScannerPage extends StatefulWidget {
  final bool isAfterLogin;

  const QRScannerPage({
    super.key,
    this.isAfterLogin = false,
  });

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  MobileScannerController? _controller;
  bool _isDialogOpen = false;
  bool _isFlashOn = false;
  bool _isCameraInitializing = true;
  int _initializationAttempts = 0;
  static const int maxInitializationAttempts = 3;

  late AnimationController _dragController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
    // Delay the initial camera setup slightly to ensure proper initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCamera();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAndDisposeCamera();
    _dragController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _initializeCamera();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _stopAndDisposeCamera();
        break;
      default:
        break;
    }
  }

  Future<void> _stopAndDisposeCamera() async {
    try {
      await _controller?.stop();
      await _controller?.dispose();
      _controller = null;
    } catch (e) {
      // Handle cleanup errors silently
    }
  }

  Future<void> _initializeCamera() async {
    if (!mounted) return;

    setState(() {
      _isCameraInitializing = true;
      _initializationAttempts++;
    });

    // Clean up any existing controller
    await _stopAndDisposeCamera();

    try {
      // Create new controller
      _controller = MobileScannerController(
        formats: [BarcodeFormat.qrCode],
        facing: CameraFacing.back,
        torchEnabled: _isFlashOn,
      );

      // Wait a moment before starting
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      // Start the camera
      await _controller!.start();

      if (mounted) {
        setState(() {
          _isCameraInitializing = false;
          _initializationAttempts = 0;
        });
      }
    } catch (e) {
      if (mounted) {
        if (_initializationAttempts < maxInitializationAttempts) {
          // Wait and try again
          Future.delayed(const Duration(milliseconds: 500), _initializeCamera);
        } else {
          setState(() {
            _isCameraInitializing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'Failed to initialize camera. Please restart the app.'),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  setState(() {
                    _initializationAttempts = 0;
                  });
                  _initializeCamera();
                },
              ),
            ),
          );
        }
      }
    }
  }

  Widget _buildCameraView() {
    if (_controller == null || _isCameraInitializing) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Initializing camera...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return MobileScanner(
      controller: _controller!,
      onDetect: _onDetect,
      errorBuilder: (context, error, child) {
        // Attempt to recover from error
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _initializationAttempts < maxInitializationAttempts) {
            _initializeCamera();
          }
        });

        return Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Camera error: ${error.errorCode}\nRetrying...',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !widget.isAfterLogin,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const CustomDrawer(),
        drawerEnableOpenDragGesture: true,
        drawerScrimColor: Colors.black54,
        body: Stack(
          children: [
            _buildCameraView(),
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
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) async {
    if (!_isDialogOpen && capture.barcodes.isNotEmpty) {
      _isDialogOpen = true;
      await _stopAndDisposeCamera();

      if (!mounted) return;

      try {
        final String scannedData = capture.barcodes.first.rawValue ?? 'No data';

        // Verify if the scanned product exists
        final product = ProductsData.getProduct(scannedData);
        if (product != null) {
          // Add to saved machines
          final wasAdded =
          Provider.of<SavedMachinesProvider>(context, listen: false)
              .addMachine(product.name);

          // Show success/info message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  wasAdded
                      ? '${product.name} added to saved machines'
                      : '${product.name} is already in your saved machines',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }

          // Navigate to product details
          if (mounted) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(productName: scannedData),
              ),
            );
          }
        } else {
          // Show error for invalid QR code
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid QR code: Product not found'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } finally {
        _isDialogOpen = false;
        if (mounted) {
          _initializeCamera();
        }
      }
    }
  }

  void _toggleFlash() {
    if (_controller != null) {
      setState(() {
        _isFlashOn = !_isFlashOn;
        _controller!.toggleTorch();
      });
    }
  }
}