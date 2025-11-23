import 'package:get/get.dart';
import 'lab_11_1_1.dart';

class PostController extends GetxController with StateMixin<List<Post>> {
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading.value = true;
    try {
      final response = await GetConnect().get('https://jsonplaceholder.typicode.com/posts');
      if (response.status.hasError) {
        error.value = 'Error fetching posts: ${response.statusText}';
      } else {
        List<Post> loadedPosts = (response.body as List)
            .map((json) => Post.fromJson(json))
            .toList();
        posts.value = loadedPosts;
        error.value = '';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

