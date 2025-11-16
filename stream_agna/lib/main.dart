import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'stream.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Subscription Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  // Variabel dari Practical 2, 3, dan 4
  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer transformer;
  late StreamSubscription subscription;

  // Practical 5, Step 1: Variabel baru
  late StreamSubscription subscription2; 
  String values = ''; 

  // Method untuk menutup Controller
  void stopStream() {
    numberStreamController.close();
  }

  // Method untuk mengirim angka (sudah dimodifikasi untuk isClosed)
  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  @override
  void initState() {
    // Practical 3: StreamTransformer
    transformer = StreamTransformer<int, int>.fromHandlers(
        handleData: (value, sink) {
          sink.add(value * 10);
        },
        handleError: (error, trace, sink) {
          sink.add(-1);
        },
        handleDone: (sink) => sink.close());

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    
    // Practical 5, Step 4: Ubah menjadi Broadcast Stream
    // dan terapkan transformer ke stream sebelum digunakan
    Stream stream = numberStreamController.stream.asBroadcastStream().transform(transformer);
    
    // Practical 5, Step 2: Listener Pertama
    subscription = stream.listen((event) {
        setState(() {
          // event sudah dikalikan 10 oleh transformer
          values += 'Event: $event '; 
          lastNumber = event; 
        });
    }); 

    // Practical 5, Step 2: Listener Kedua (SEKARANG BEKERJA karena Broadcast Stream)
    subscription2 = stream.listen((event) {
        setState(() {
          values += 'Event: $event ';
        });
    }); 

    // Practical 4: Penanganan Error dan onDone (hanya perlu pada salah satu subscription)
    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    }); 

    subscription.onDone(() {
      print('OnDone was called');
    });
    
    // Pastikan subscription2 juga dibatalkan saat dispose
    subscription2.onError((error) {});
    subscription2.onDone(() {});

    super.initState();
  }

  @override
  void dispose() {
    // Batalkan kedua subscriptions
    subscription.cancel();
    subscription2.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Broadcast Demo')),
      body: SizedBox (
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Practical 5, Step 5: Tampilkan nilai gabungan dari kedua listener
            Text(values), 
            // Tampilkan angka terakhir (dari listener pertama)
            Text(
              lastNumber.toString(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            // Tombol untuk memicu pengiriman data
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: const Text('New Random Number'),
            ),
            // Tombol untuk Stop Subscription
            ElevatedButton(
              onPressed: () => stopStream(),
              child: const Text('Stop Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}

  // class StreamHomePage extends StatefulWidget {
  //   const StreamHomePage({super.key});

  //   @override
  //   State<StreamHomePage> createState() => _StreamHomePageState();
  // }

  // class _StreamHomePageState extends State<StreamHomePage> {
  //   Color bgColor = Colors.blueGrey;
  //   late ColorStream colorStream;

  //   @override
  //   void initState() {
  //     super.initState();
  //     colorStream = ColorStream();
  //     changeColor();
  //   }

  //   void changeColor() {
  //     colorStream.getColors().listen((eventColor) {
  //       setState(() {
  //         bgColor = eventColor;
  //       });
  //     });
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text('Stream')),
  //       body: Container(decoration: BoxDecoration(color: bgColor)),
  //     );
  //   }

