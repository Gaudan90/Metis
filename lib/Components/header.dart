import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../admin_page.dart';

class Header extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const Header({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
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
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Selmi-Group',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        authState.isAuthenticated ? Icons.edit_off : Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        authState.setAuthenticated(!authState.isAuthenticated);
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
