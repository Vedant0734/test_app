import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 22),
        children: [
          const TextSpan(
              text: 'BGI',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black54)),
          TextSpan(
              text: 'Test',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent.shade700)),
        ],
      ),
    );
  }
}
