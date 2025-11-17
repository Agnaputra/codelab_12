// main.dart
import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  // Step 5: Tambahkan variabel Stream
  late Stream<int> numberStream;

  @override
  void initState() {
    // Step 6: Inisialisasi Stream
    numberStream = NumberStream().getNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StreamBuilder Demo"),
      ),
      // Step 7: Gunakan StreamBuilder
      body: StreamBuilder<int>(
        stream: numberStream,
        initialData: 0, // Nilai awal sebelum data pertama tiba
        builder: (context, snapshot) {
          
          // 1. Penanganan Error
          if (snapshot.hasError) {
            print('Error! ${snapshot.error}');
            return const Center(child: Text('Error!'));
          }

          // 2. Penanganan Data
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(fontSize: 96),
              ),
            );
          } 
          
          // 3. Penanganan Loading (snapshot.hasData false)
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}