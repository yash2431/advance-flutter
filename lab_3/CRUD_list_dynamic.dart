// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(CrudApp());
}

class CrudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD with List<dynamic>',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CrudHomeScreen(),
    );
  }
}

class CrudHomeScreen extends StatefulWidget {
  @override
  _CrudHomeScreenState createState() => _CrudHomeScreenState();
}

class _CrudHomeScreenState extends State<CrudHomeScreen> {
  List<dynamic> items = []; // Our dynamic list
  TextEditingController controller = TextEditingController();

  void _addItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        items.add(controller.text);
        controller.clear();
      });
    }
  }

  void _editItem(int index) {
    TextEditingController editController =
    TextEditingController(text: items[index]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Item'),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: 'Enter new value'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (editController.text.isNotEmpty) {
                setState(() {
                  items[index] = editController.text;
                });
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Input field and add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // List of items
            Expanded(
              child: items.isEmpty
                  ? Center(child: Text('No items yet.'))
                  : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(items[index].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editItem(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
