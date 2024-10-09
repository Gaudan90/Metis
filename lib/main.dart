// Import required packages
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // For QR code scanning functionality
import 'product_details_page_legend.dart'; // Custom page for displaying product details

// Entry point of the application
void main() => runApp(const MainApp());

/// Root widget of the application
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: QRScanner(), // Set QRScanner as the main content
      ),
    );
  }
}

/// Widget for QR code scanning functionality
class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

/// State class for QRScanner
class _QRScannerState extends State<QRScanner>
    with SingleTickerProviderStateMixin {
  // Controller for the mobile scanner
  late MobileScannerController controller;
  
  // State variables
  bool isDialogOpen = false; // Prevents multiple dialogs from opening
  bool isFlashOn = false;   // Tracks flashlight state
  
  // Controller for the bottom sheet drag animation
  late AnimationController dragController;

  // Constants
  final double minHeight = 100;  // Minimum height of bottom sheet
  final double maxHeight = 600;  // Maximum height of bottom sheet
  final Color customBlue = const Color(0xFF092d52); // Custom brand color

  @override
  void initState() {
    super.initState();
    // Initialize controllers
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
        // QR Scanner camera view
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            // Handle QR code detection
            if (!isDialogOpen && capture.barcodes.isNotEmpty) {
              isDialogOpen = true;
              controller.stop(); // Stop scanning
              final String scannedData =
                  capture.barcodes.first.rawValue ?? 'No data';
              
              // Navigate to product details page
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(scannedData: scannedData),
                ),
              )
                  .then((_) {
                // Reset state when returning from product details
                isDialogOpen = false;
                controller.start();
              });
            }
          },
        ),
        // UI overlay
        Column(
          children: [
            _buildHeader(),    // Top header with controls
            const Spacer(),
            _buildBottomSheet(), // Draggable bottom sheet
          ],
        ),
      ],
    );
  }

  /// Builds the top header with menu and control buttons
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
                // Menu button
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Menu functionality to be implemented
                  },
                ),
                // Control buttons
                Row(
                  children: [
                    // Flashlight toggle button
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
                    // Photo library button
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      onPressed: () {
                        // Photo library functionality to be implemented
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

  /// Builds the draggable bottom sheet with product cards
  Widget _buildBottomSheet() {
    return GestureDetector(
      // Handle vertical drag to expand/collapse bottom sheet
      onVerticalDragUpdate: (details) {
        dragController.value -= details.primaryDelta! / (maxHeight - minHeight);
      },
      onVerticalDragEnd: (details) {
        if (dragController.value > 0.5) {
          dragController.forward(); // Expand fully if dragged more than halfway
        } else {
          dragController.reverse(); // Collapse if dragged less than halfway
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
                // Drag indicator
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
                // Conditional content based on drag state
                if (dragController.value > 0.2) ...[
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Product cards
                            _buildCard(
                              imageUrl: 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
                              title: 'LEGEND',
                              year: '2024',
                            ),
                            const SizedBox(height: 16),
                            _buildCard(
                              imageUrl: 'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
                              title: 'TRUFFLE',
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

  /// Builds a product card with image, title, and year
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
            // Product image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            // Product details
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

  /// Helper function to interpolate between min and max heights
  double lerp(double min, double max) =>
      min + (max - min) * dragController.value;

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    controller.dispose();
    dragController.dispose();
    super.dispose();
  }
}