// main.dart
import 'package:flutter/material.dart';
import 'random_screen.dart'; // Import RandomScreen
import 'dart:async';

void main() {
  runApp(const MyApp());
}

// Step 7: Edit main.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomScreen(), // Menggunakan RandomScreen
    );
  }
}