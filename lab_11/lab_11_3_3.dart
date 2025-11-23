import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_11_3_2.dart';

void main() {
  runApp(const SearchApiApp());
}

class SearchApiApp extends StatelessWidget {
  const SearchApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Search API with GetX',
      home: const PostSearchScreen(),
    );
  }
}

class PostSearchScreen extends StatelessWidget {
  const PostSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search API with Real-time Filter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredPosts.isEmpty) {
                return const Center(child: Text('No results found'));
              }
              return ListView.builder(
                itemCount: controller.filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = controller.filteredPosts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
