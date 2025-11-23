import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_11_1_2.dart';

void main() {
  runApp(const GetXApiApp());
}

class GetXApiApp extends StatelessWidget {
  const GetXApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX REST API Example',
      home: const PostListScreen(),
    );
  }
}

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts from API'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.error.value.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        } else {
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
