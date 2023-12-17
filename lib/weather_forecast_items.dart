import 'package:flutter/material.dart';

class MyWidgetclass extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  const MyWidgetclass({
    super.key,
    required this.temp,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 110,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                maxLines: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Icon(
                icon,
                size: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                temp,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
