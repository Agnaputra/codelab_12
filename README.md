# STREAMS

## Lab 1: Dart Streams

### Step 1: Create a New Project
Create a new flutter project named stream_name (give it your nickname) in the week-12/src/ folder of your GitHub repository.

![alt text](stream_agna/images/lab1/1.png)

### Step 2: Open the filemain.dart
Type the code as follows.

```dart:
import 'package:flutter/material.dart';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream - Agna',   // Jawaban Q1
      theme: ThemeData(
        primarySwatch: Colors.blue,   // Diganti sesuai selera (Jawaban Q1)
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
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    changeColor();
  }

  void changeColor() async {
    await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream')),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
      ),
    );
  }
}
```

- Question 1
Add your nickname to titlethe app as an identity for your work.
Change the application theme color according to your preference.
Commit the answer to Question 1 with the message "W12: Answer to Question 1"

The answer is on step 1 and 2

### Step 3: Create a new filestream.dart
Create a new file in your project's lib folder. Then, fill it with the following code.

```dart:
import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,

    // 5 warna tambahan (jawaban Q2)
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) {
        int index = t % colors.length;
        return colors[index];
      },
    );
  }
}
```

### Step 4: Add variablescolors
Add variables inside the class ColorStreamas follows.

```dart:
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ]
```
- Question 2
Add 5 more colors as you wish to colorsthe variable.
Commit the answer to Question 2 with the message "W12: Answer to Question 2"

```dart:
    // 5 warna tambahan (jawaban Q2)
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
  ];
```

### Step 5: Add methodgetColors()
In class ColorStreamthe method, type the following code. Note the asterisk at the end of the keyword async*(this is used to execute Streamdata).

```dart:
  Stream<Color> getColors() async* {
```

### Step 6: Add commandsyield*
Add the following code.

```dart:
yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) {
        int index = t % colors.length;
        return colors[index];
      },
    );
```

- Question 3
Explain the function of the keyword yield*in the code!
What does the code command mean?
Commit the answer to Question 3 with the message "W12: Answer to Question 3"

The yield* keyword is used to forward all events from another stream to the stream being created.

```dart:
yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) {
        int index = t % colors.length;
        return colors[index];
      },
    );
```
This means:

    - Stream.periodic generates a new color every 1 second,

    - and yield* sends all those color events to the caller of getColors().

So, yield* acts as an intermediary that forwards other streams without having to manually process each event individually.

### Step 7: Openmain.dart
Type this file import code in the filemain.dart

![alt text](stream_agna/images/lab1/2.png)

### Step 8: Add variables
Type these two properties insideclass _StreamHomePageState

![alt text](stream_agna/images/lab1/3.png)

### Step 9: Add methodchangeColor()
Stay in the main file, type the code as follows

![alt text](stream_agna/images/lab1/4.png)

### Step 10: Perform overrideinitState()
When the code is like this

![alt text](stream_agna/images/lab1/5.png)

### Step 11: Change the contentsScaffold()
Adjust the code as follows.

![alt text](stream_agna/images/lab1/6.png)

### Step 12: Run
Run your Flutter application and you will see the background color change every second.

![alt text](stream_agna/images/lab1/7.png) 

![alt text](stream_agna/images/lab1/8.png)

- Question 4
Capture your practical results in GIF format and attach them to the README.
Commit the answer to Question 4 with the message "W12: Answer to Question 4"

![alt text](stream_agna/images/lab1/9.gif)

### Step 13: Change the contents of the methodchangeColor()
You can comment or delete the previous code, then when the code is like the following.

![alt text](stream_agna/images/lab1/10.png)

- Question 5
Explain the difference between using listenand await for(step 9)!
Commit the answer to Question 5 with the message "W12: Answer to Question 5"

![alt text](stream_agna/images/lab1/11.gif)

1. await for
    - Used inside async functions.
    - Waits for each Stream data item sequentially (synchronous-like).
    - The process is blocking within the function until the Stream completes.
    - Suitable if you want to:
       -  process data one by one
        - wait for the stream to close before moving on to the next line

Example:
```dart
await for (var event in stream) {
print(event);
}
```

2. listen()
    - No need for async.
    - Produces a subscription that runs in the background.
    - The process is non-blocking, so other code continues running.
    - Suitable for:
        - Real-time UI updates
        - Reading a Stream that will never finish
        - Recurring events such as timers, sensors, or color changes

Example:
```dart:
stream.listen((event) {
print(event);
});
```