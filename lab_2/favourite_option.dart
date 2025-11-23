// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Static list holder class
class StaticData {
  static List<Fruit> fruits = [
    Fruit(name: 'Apple'),
    Fruit(name: 'Banana'),
    Fruit(name: 'Orange'),
    Fruit(name: 'Mango'),
    Fruit(name: 'Grapes'),
  ];
}

// Model class
class Fruit {
  String name;
  bool isFavorite;

  Fruit({required this.name, this.isFavorite = false});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleFavorite(int index) {
    setState(() {
      StaticData.fruits[index].isFavorite = !StaticData.fruits[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Static List with Favorite',
      home: Scaffold(
        appBar: AppBar(title: Text('Favorite Fruits')),
        body: ListView.builder(
          itemCount: StaticData.fruits.length,
          itemBuilder: (context, index) {
            final fruit = StaticData.fruits[index];
            return ListTile(
              title: Text(fruit.name),
              trailing: IconButton(
                icon: Icon(
                  fruit.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: fruit.isFavorite ? Colors.red : null,
                ),
                onPressed: () => toggleFavorite(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
