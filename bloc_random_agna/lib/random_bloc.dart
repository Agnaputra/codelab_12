// random_bloc.dart
import 'dart:async';
import 'dart:math';

// Step 3: Create class RandomNumberBloc()
class RandomNumberBloc {
  // Step 4: Create variables StreamController

  // StreamController for input events (menerima sinyal untuk generate)
  // Inputnya void karena kita hanya butuh sinyal, bukan data spesifik.
  final generateRandomController = StreamController<void>();
  
  // StreamController for output (mengeluarkan angka random)
  final _randomNumberController = StreamController<int>();

  // Input Sink (diekspos ke UI untuk mengirim event)
  Sink<void> get generateRandom => generateRandomController.sink;
  
  // Output Stream (diekspos ke UI untuk mendengarkan perubahan state)
  Stream<int> get randomNumber => _randomNumberController.stream;

  // Step 5: Create a constructor
  RandomNumberBloc() {
    // Mendengarkan stream input
    generateRandomController.stream.listen((_) {
      // Ketika sinyal diterima, generate angka random
      final random = Random().nextInt(10);
      
      // Kirim hasil angka random ke stream output
      _randomNumberController.sink.add(random);
    });
  }

  // Step 6: Create a method dispose()
  void dispose() {
    // Menutup kedua controller untuk menghindari memory leak
    generateRandomController.close();
    _randomNumberController.close();
  }
}