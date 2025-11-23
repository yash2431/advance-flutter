// file: main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  // Example product list
  final List<Map<String, String>> products = [
    {'name': 'Laptop', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Headphones', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Smartphone', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Shoes', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Watch', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Bag', 'image': 'https://via.placeholder.com/150'},
  ];

  // Example categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Electronics', 'icon': Icons.devices},
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Home', 'icon': Icons.chair},
    {'name': 'Sports', 'icon': Icons.sports_soccer},
    {'name': 'Books', 'icon': Icons.menu_book},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {}, // Add action here
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          // Categories
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Icon(categories[index]['icon'], size: 24),
                        radius: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        categories[index]['name'],
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          // Section title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Featured Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Product grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two products per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            products[index]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index]['name']!,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {}, // Add action
                        child: Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(100, 36),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
