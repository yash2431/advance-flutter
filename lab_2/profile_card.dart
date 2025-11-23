// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      appBar: AppBar(
        title: Text('Profile Card'),
      ),
      body: Center(
        child: Card(
          elevation: 8, // Shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Fit to content
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  // Use NetworkImage('https://...') or AssetImage
                  // If no image, you can use child: Icon(Icons.person, size: 50)
                ),
                SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'johndoe@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 4),
                Text(
                  '+1 234 567 890',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('New York, USA'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
