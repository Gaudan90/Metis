import 'package:flutter/material.dart';
import 'product_card.dart';

class BottomSheett extends StatelessWidget {
  final AnimationController dragController;
  final double minHeight = 100;
  final double maxHeight = 600;
  final Color customBlue = const Color(0xFF092d52);

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
                          children: const [
                            ProductCard(
                              imageUrl: 'https://www.selmi-group.it/img/macchine-temperaggio-cioccolato/legend-temperatrice-cioccolato/legend-temperatrice-cioccolato.png',
                              title: 'LEGEND',
                              year: '2024',
                            ),
                            SizedBox(height: 16),
                            ProductCard(
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

  double lerp(double min, double max) =>
      min + (max - min) * dragController.value;
}