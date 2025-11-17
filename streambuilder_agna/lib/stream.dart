// stream.dart
import 'dart:async';
import 'dart:math';

class NumberStream {
  // Step 3: Method yang mengembalikan Stream periodik
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      Random random = Random();
      int myNum = random.nextInt(10);
      return myNum; // Mengembalikan angka acak (0-9)
    });
  }
}