// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Class with static variable
class Counter {
  static int count = 0;
}

// First class updates the static variable
class ClassA {
  void increment() {
    Counter.count += 5;
    print('ClassA incremented count to ${Counter.count}');
  }
}

// Second class updates the static variable
class ClassB {
  void increment() {
    Counter.count += 3;
    print('ClassB incremented count to ${Counter.count}');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create instances
    ClassA a = ClassA();
    ClassB b = ClassB();

    // Access and modify static variable from both classes
    a.increment(); // count becomes 0 + 5 = 5
    b.increment(); // count becomes 5 + 3 = 8

    // Read final value
    int finalCount = Counter.count;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Static Variable Example')),
        body: Center(
          child: Text(
            'Final static count value: $finalCount',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
