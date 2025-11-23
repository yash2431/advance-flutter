// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Base class
class Animal {
  void makeSound() {
    print('Animal makes a sound');
  }
}

// Subclass overriding makeSound
class Dog extends Animal {
  @override
  void makeSound() {
    print('Dog barks');
  }
}

// Another subclass overriding makeSound
class Cat extends Animal {
  @override
  void makeSound() {
    print('Cat meows');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Creating instances
    Animal genericAnimal = Animal();
    Animal dog = Dog();
    Animal cat = Cat();

    // Calling overridden methods
    genericAnimal.makeSound(); // Output: Animal makes a sound
    dog.makeSound();           // Output: Dog barks
    cat.makeSound();           // Output: Cat meows

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Method Overriding Example')),
        body: Center(
          child: Text(
            'Check the console output to see method overriding in action!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
