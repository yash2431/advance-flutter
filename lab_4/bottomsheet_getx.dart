// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(   // Use GetMaterialApp
      title: 'GetX BottomSheet Example',
      home: BottomSheetExampleScreen(),
    );
  }
}

class BottomSheetExampleScreen extends StatelessWidget {
  // Example list of data
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  void showMyBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              leading: Icon(Icons.label),
              onTap: () {
                Get.back(); // Close BottomSheet
                Get.snackbar('Selected', 'You tapped ${items[index]}');
              },
            );
          },
        ),
      ),
      isScrollControlled: true, // make sheet full height if needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX BottomSheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showMyBottomSheet,
          child: Text('Show BottomSheet'),
        ),
      ),
    );
  }
}
