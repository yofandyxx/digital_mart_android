import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DigitalMartApp());
}

class DigitalMartApp extends StatelessWidget {
  const DigitalMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}