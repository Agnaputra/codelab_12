import 'dart:async';

// class ColorStream {
//   final List<Color> colors = [
//     Colors.blueGrey,
//     Colors.amber,
//     Colors.deepPurple,
//     Colors.lightBlue,
//     Colors.teal,

//     // 5 warna tambahan (jawaban Q2)
//     Colors.red,
//     Colors.green,
//     Colors.orange,
//     Colors.pink,
//     Colors.indigo,
//   ];

//   Stream<Color> getColors() async* {
//     yield* Stream.periodic(
//       const Duration(seconds: 1),
//       (int t) {
//         int index = t % colors.length;
//         return colors[index];
//       },
//     );
//   }
// }
class NumberStream {
  // Step 3: StreamController is the bridge between Sink and Stream.
  // It handles integer data (<int>).
  final StreamController<int> controller = StreamController<int>();

  // Step 4: Method to add a new number to the Sink (input).
  void addNumberToSink(int newNumber) {
    controller.sink.add(newNumber);
  }

  // Step 13: Method to add an error to the Sink.
  addError() {
    controller.sink.addError('error');
  }

  // Step 5: Method to close the controller and release resources.
  void close() {
    controller.close();
  }
}
