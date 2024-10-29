import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Data/products_data.dart';
import 'package:flutter_application_1/Data/saved_machines_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details_page.dart';
import 'package:flutter_application_1/Components/bottom_sheet.dart';
import 'package:flutter_application_1/Components/header.dart';
import 'Components/custom_drawer.dart';
import 'choice_page.dart';

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

    await _stopAndDisposeCamera();

    try {
      _controller = MobileScannerController(
        formats: [BarcodeFormat.qrCode],
        facing: CameraFacing.back,
        torchEnabled: _isFlashOn,
      );

      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

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

  Widget _buildScannerOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSize = 300.0; // Your desired window size
        final cornerRadius = 20.0; // Your desired corner radius

        // Calculate window position
        final windowTop = (constraints.maxHeight - windowSize) / 2;

        // Position text 20 pixels below the window
        final textTop = windowTop + windowSize + 20;

        return Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: ScannerOverlayPainter(
                windowSize: windowSize,
                cornerRadius: cornerRadius,
              ),
            ),
            Positioned(
              top: textTop, // Dynamic positioning
              left: 0,
              right: 0,
              child: Text(
                'Scan your machine\'s QR code',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  fontSize: 24,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
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

    return Stack(
      children: [
        MobileScanner(
          controller: _controller!,
          onDetect: _onDetect,
          errorBuilder: (context, error, child) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted &&
                  _initializationAttempts < maxInitializationAttempts) {
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
        ),
        _buildScannerOverlay(),
      ],
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

        final product = ProductsData.getProduct(scannedData);
        if (product != null) {
          final savedMachinesProvider =
              Provider.of<SavedMachinesProvider>(context, listen: false);

          if (savedMachinesProvider.isMachineSaved(product.name)) {
            if (mounted) {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    productName: scannedData,
                    language: "English",
                    year: "2024",
                  ),
                ),
              );
            }
          } else {
            if (mounted) {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChoicePage(
                    productName: scannedData,
                  ),
                ),
              );

              final wasAdded = savedMachinesProvider.addMachine(product.name);

              if (mounted && wasAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to saved machines'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            }
          }
        } else {
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

class ScannerOverlayPainter extends CustomPainter {
  final double windowSize;
  final double cornerRadius;

  ScannerOverlayPainter({
    this.windowSize = 300,
    this.cornerRadius = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    final double left = (size.width - windowSize) / 2;
    final double top = (size.height - windowSize) / 2;

    // Create a path for the entire screen
    Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a path for the scanner window with rounded corners
    RRect windowRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, windowSize, windowSize),
      Radius.circular(cornerRadius),
    );
    Path windowPath = Path()..addRRect(windowRRect);

    // Subtract the window path from the main path to create the cutout
    final cutoutPath = Path.combine(
      PathOperation.difference,
      path,
      windowPath,
    );

    canvas.drawPath(cutoutPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
