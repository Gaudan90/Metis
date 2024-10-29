// bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_card.dart';
import '../product_details_page.dart';
import '../Data/saved_machines_provider.dart';
import '../Data/products_data.dart';

class BottomSheett extends StatelessWidget {
  final AnimationController dragController;
  final double minHeight = 100;
  final double maxHeight = 700;
  final Color customBlue = const Color(0xFF092d52);
  final Color lightGrayBackground = const Color(0xFFF8F9FA);

  const BottomSheett({
    super.key,
    required this.dragController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedMachinesProvider>(
      builder: (context, savedMachinesProvider, child) {
        final savedMachines = savedMachinesProvider.savedMachines;

        return GestureDetector(
          onVerticalDragUpdate: (details) {
            dragController.value -=
                details.primaryDelta! / (maxHeight - minHeight);
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
              return SizedBox(
                height: lerp(minHeight, maxHeight),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // Blue header
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: customBlue.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'SAVED MACHINES',
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
                    // Saved machines list
                    Expanded(
                      child: Container(
                        color: lightGrayBackground,
                        child: savedMachines.isEmpty
                            ? Center(
                                child: Text(
                                  'Scan a QR code to add machines',
                                  style: GoogleFonts.dosis(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                physics: dragController.value > 0.2
                                    ? const AlwaysScrollableScrollPhysics()
                                    : const NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: savedMachines.map((productName) {
                                      final product =
                                          ProductsData.getProduct(productName);
                                      if (product == null)
                                        return const SizedBox();

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Dismissible(
                                          key: Key(product.name),
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            color: Colors.red,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onDismissed: (_) {
                                            savedMachinesProvider
                                                .removeMachine(product.name);
                                          },
                                          child: ProductCard(
                                            imageUrl: product.imageUrl,
                                            title: product.name,
                                            year: product.year,
                                            onTap: () =>
                                                _navigateToProductDetails(
                                              context,
                                              product.name,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToProductDetails(BuildContext context, String productName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(productName: productName),
      ),
    );
  }

  double lerp(double min, double max) =>
      min + (max - min) * dragController.value;
}
