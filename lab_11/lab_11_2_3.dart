import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lab_11_2_2.dart';

void main() {
  runApp(const ApiStateApp());
}

class ApiStateApp extends StatelessWidget {
  const ApiStateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'API State Example',
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
        title: const Text('API Loading, Success, Error'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchPosts,
          ),
        ],
      ),
      body: Obx(() {
        switch (controller.state.value) {
          case ApiState.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiState.success:
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
          case ApiState.error:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchPosts,
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
        }
      }),
    );
  }
}
