import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Responsive Form with GetX",
      home: const ResponsiveFormScreen(),
    );
  }
}

class ResponsiveFormScreen extends StatelessWidget {
  const ResponsiveFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responsive Form Example")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth >= 600;
          bool isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;

          if (isTablet) {
            // Tablet Layout
            return isPortrait
                ? const TabletPortraitForm()
                : const TabletLandscapeForm();
          } else {
            // Mobile Layout
            return isPortrait
                ? const MobilePortraitForm()
                : const MobileLandscapeForm();
          }
        },
      ),
    );
  }
}

//
// Mobile - Portrait
//
class MobilePortraitForm extends StatelessWidget {
  const MobilePortraitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          TextField(
            decoration: InputDecoration(labelText: "Full Name"),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

//
// Mobile - Landscape
//
class MobileLandscapeForm extends StatelessWidget {
  const MobileLandscapeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Full Name"),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Email"),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Password"),
            ),
          ),
        ],
      ),
    );
  }
}

//
// Tablet - Portrait
//
class TabletPortraitForm extends StatelessWidget {
  const TabletPortraitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: const [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Full Name"),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

//
// Tablet - Landscape
//
class TabletLandscapeForm extends StatelessWidget {
  const TabletLandscapeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Full Name"),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Email"),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Password"),
            ),
          ),
        ],
      ),
    );
  }
}
