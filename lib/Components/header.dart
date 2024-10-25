import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback onFlashToggle;
  final VoidCallback onMenuPressed;

  const Header({
    super.key,
    required this.isFlashOn,
    required this.onFlashToggle,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF092d52).withOpacity(0.9),
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
                  onPressed: onMenuPressed,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: onFlashToggle,
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
}
