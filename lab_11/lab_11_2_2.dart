import 'package:get/get.dart';
import 'lab_11_2_1.dart';

enum ApiState { loading, success, error }

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var state = ApiState.loading.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    state.value = ApiState.loading;
    try {
      final response = await GetConnect().get('https://jsonplaceholder.typicode.com/posts');

      if (response.status.hasError) {
        state.value = ApiState.error;
        errorMessage.value = 'Failed to load posts: ${response.statusText}';
      } else {
        posts.value = (response.body as List)
            .map((json) => Post.fromJson(json))
            .toList();
        state.value = ApiState.success;
      }
    } catch (e) {
      state.value = ApiState.error;
      errorMessage.value = 'Error: $e';
    }
  }
}
