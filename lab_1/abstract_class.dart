// file: main.dart
import 'package:flutter/material.dart';
import 'dart:math'; // for pi

void main() {
  runApp(MyApp());
}

// Abstract class
abstract class Shape {
  double area(); // abstract method
}

// Child class implementing abstract method
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() {
    return pi * radius * radius;
  }
}

// Another child class implementing abstract method
class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area() {
    return width * height;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create instances
    Shape circle = Circle(5);
    Shape rectangle = Rectangle(4, 6);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Abstract Classes Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Circle Area: ${circle.area().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Rectangle Area: ${rectangle.area().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
