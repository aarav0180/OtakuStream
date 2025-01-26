import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;

  const CustomSnackBar({
    super.key,
    required this.message,
    required this.backgroundColor,
    this.icon = Icons.check_circle,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _createAnimation(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Animation<Offset> _createAnimation(BuildContext context) {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Scaffold.of(context),
    )..forward();
    return Tween<Offset>(
      begin: const Offset(0, 1.0), // Start from below the screen
      end: Offset.zero, // Slide to its normal position
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
  }
}
