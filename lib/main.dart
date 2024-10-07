import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'product_details_page.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: QRScanner(),
      ),
    );
  }
}

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner>
    with SingleTickerProviderStateMixin {
  late MobileScannerController controller;
  bool isDialogOpen = false;
  bool isFlashOn = false;
  late AnimationController dragController;

  final double minHeight = 100;
  final double maxHeight = 600;
  final Color customBlue = const Color(0xFF092d52);

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
          onDetect: (capture) {
            if (!isDialogOpen && capture.barcodes.isNotEmpty) {
              isDialogOpen = true;
              controller.stop();
              final String scannedData =
                  capture.barcodes.first.rawValue ?? 'No data';
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(scannedData: scannedData),
                ),
              )
                  .then((_) {
                isDialogOpen = false;
                controller.start();
              });
            }
          },
        ),
        Column(
          children: [
            _buildHeader(),
            const Spacer(),
            _buildBottomSheet(),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: customBlue.withOpacity(0.9),
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(height: 0),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Menu functionality
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isFlashOn = !isFlashOn;
                          controller.toggleTorch();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      onPressed: () {
                        // Photo library functionality
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        dragController.value -= details.primaryDelta! / (maxHeight - minHeight);
      },
      onVerticalDragEnd: (details) {
        if (dragController.value > 0.5) {
          dragController.forward();
        } else {
          dragController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: dragController,
        builder: (context, child) {
          return Container(
            height: lerp(minHeight, maxHeight),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: customBlue.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Drag up for more',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (dragController.value > 0.2) ...[
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildCard(
                              imageUrl: 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
                              title: 'LEGEND',
                              year: '2024',
                            ),
                            const SizedBox(height: 16),
                            _buildCard(
                              imageUrl: '/api/placeholder/120/120',
                              title: 'Scanner Product Two',
                              year: '2023',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required String imageUrl,
    required String title,
    required String year,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Year: $year',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double lerp(double min, double max) =>
      min + (max - min) * dragController.value;

  @override
  void dispose() {
    controller.dispose();
    dragController.dispose();
    super.dispose();
  }
}