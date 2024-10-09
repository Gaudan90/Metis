import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_card.dart';
import '../product_details_page.dart';

class BottomSheett extends StatelessWidget {
  final AnimationController dragController;
  final double minHeight = 100;
  final double maxHeight = 600;
  final Color customBlue = const Color(0xFF092d52);
  final Color lightGrayBackground = const Color(0xFFF8F9FA);

  const BottomSheett({
    super.key,
    required this.dragController,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                // Blue header - always on top, full width, with shadow
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
                        'DRAG UP FOR MORE',
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
                // Bottom content - scrollable
                Expanded(
                  child: Container(
                    color: lightGrayBackground,
                    child: SingleChildScrollView(
                      physics: dragController.value > 0.2
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ProductCard(
                              imageUrl:
                                  'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
                              title: 'LEGEND',
                              year: '2024',
                              onTap: () =>
                                  _navigateToProductDetails(context, 'LEGEND'),
                            ),
                            const SizedBox(height: 16),
                            ProductCard(
                              imageUrl:
                                  'https://www.selmi-group.it/img/truffle-nastro-ricopertura-tartufi/truffle-nastro-ricopertura-tartufi-p.png',
                              title: 'TRUFFLE',
                              year: '2023',
                              onTap: () =>
                                  _navigateToProductDetails(context, 'TRUFFLE'),
                            ),
                            // TODO: Remove these placeholder cards or replace with actual products
                          ],
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
