import 'package:flutter/material.dart';

class AdditionalInfo_items extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfo_items({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }
}
