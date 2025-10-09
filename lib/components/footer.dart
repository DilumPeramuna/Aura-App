import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AURA",
                    style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Curated gemstone jewelry,\nDelivered with trust and elegance.",
                    style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 13),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Follow Us",
                    style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.facebook, color: colorScheme.onSurface),
                      const SizedBox(width: 10),
                      Icon(Icons.camera_alt, color: colorScheme.onSurface),
                      const SizedBox(width: 10),
                      Icon(Icons.push_pin, color: colorScheme.onSurface),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "© 2024 Aura Jewellers. All Rights Reserved.",
              style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.5), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
