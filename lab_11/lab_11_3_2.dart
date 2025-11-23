import 'package:get/get.dart';
import 'lab_11_3_1.dart';

class PostController extends GetxController {
  var allPosts = <Post>[].obs;           // All fetched posts
  var filteredPosts = <Post>[].obs;      // Filtered posts
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    // Filter whenever searchQuery changes
    ever(searchQuery, (_) => filterPosts());
  }

  void fetchPosts() async {
    isLoading.value = true;
    try {
      final response = await GetConnect().get('https://jsonplaceholder.typicode.com/posts');
      if (!response.status.hasError) {
        allPosts.value = (response.body as List)
            .map((json) => Post.fromJson(json))
            .toList();
        filteredPosts.value = allPosts;
      } else {
        Get.snackbar('Error', 'Failed to fetch posts');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterPosts() {
    String query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredPosts.value = allPosts;
    } else {
      filteredPosts.value = allPosts.where((post) {
        return post.title.toLowerCase().contains(query) ||
            post.body.toLowerCase().contains(query);
      }).toList();
    }
  }
}
