// random_screen.dart
import 'package:flutter/material.dart';
// Sesuaikan path import jika nama project berbeda
import 'random_bloc.dart'; 

// Step 10: Create a StatefulWidget RandomScreen
class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  // Step 11: Create variables (instance BLoC)
  final _bloc = RandomNumberBloc();

  // Step 12: Create a method dispose()
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  // Step 13: Edit method build()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Number')),
      body: Center(
        // StreamBuilder mendengarkan Stream output BLoC
        child: StreamBuilder<int>(
          stream: _bloc.randomNumber,
          initialData: 0,
          builder: (context, snapshot) {
            // Membangun ulang UI setiap kali BLoC mengeluarkan data baru
            return Text(
              'Random Number: ${snapshot.data}',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Tombol mengirim event ke Sink input BLoC
        onPressed: () => _bloc.generateRandom.add(null),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}