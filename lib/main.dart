import 'package:flutter/material.dart';
import 'package:weather/WeatherScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData.light(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}
