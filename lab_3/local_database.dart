import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(CrudApp());
}

class CrudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, dynamic>> userList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String gender = 'Male';

  int? selectedUID; // for edit

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<void> refreshList() async {
    var data = await DBHelper.getUsers();
    setState(() {
      userList = data;
    });
  }

  Future<void> saveUser() async {
    if (nameController.text.isEmpty || cityController.text.isEmpty) return;

    Map<String, dynamic> user = {
      'Name': nameController.text,
      'City': cityController.text,
      'Gender': gender
    };

    if (selectedUID == null) {
      await DBHelper.insertUser(user);
    } else {
      await DBHelper.updateUser(selectedUID!, user);
    }

    nameController.clear();
    cityController.clear();
    gender = 'Male';
    selectedUID = null;

    refreshList();
  }

  void editUser(Map<String, dynamic> user) {
    setState(() {
      nameController.text = user['Name'];
      cityController.text = user['City'];
      gender = user['Gender'];
      selectedUID = user['UID'];
    });
  }

  Future<void> deleteUser(int uid) async {
    await DBHelper.deleteUser(uid);
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User CRUD (SQLite)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Form
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            Row(
              children: [
                Text('Gender:'),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value!),
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) => setState(() => gender = value!),
                ),
                Text('Female'),
              ],
            ),
            ElevatedButton(
              onPressed: saveUser,
              child: Text(selectedUID == null ? 'Add User' : 'Update User'),
            ),
            SizedBox(height: 12),
            Divider(),
            // List
            Expanded(
              child: userList.isEmpty
                  ? Center(child: Text('No users found'))
                  : ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  var user = userList[index];
                  return Card(
                    child: ListTile(
                      title: Text('${user['Name']} (${user['Gender']})'),
                      subtitle: Text('City: ${user['City']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editUser(user),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteUser(user['UID']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
