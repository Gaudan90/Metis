import 'package:flutter/material.dart';
import '../edit_machine_list.dart';

class Header extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const Header({
    super.key,
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
              children: [
                const SizedBox(width: 16), // Margine a sinistra
                Expanded(
                  child: Center(
                    child: Text(
                      'Selmi-Group',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20, // Dimensione del testo
                        fontWeight: FontWeight.bold, // Grassetto
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditMachineList()),
                    );
                  },
                ),
                const SizedBox(width: 16), // Margine a destra
              ],
            ),
          ),
        ],
      ),
    );
  }
}
