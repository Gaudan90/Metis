import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ScannerHeader extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback onFlashPressed;

  const ScannerHeader({
    super.key,
    required this.isFlashOn,
    required this.onFlashPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.customBlue.withOpacity(0.9),
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
                  onPressed: () {},
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: onFlashPressed,
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.photo_library, color: Colors.white),
                      onPressed: () {},
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
}
