// lib/services/api_service.dart
import 'package:get/get.dart';
import 'model.dart';

class ApiService extends GetConnect {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // POST request
  Future<Response> createUser(User user) {
    return post('$baseUrl/users', user.toJson());
  }

  // PUT request
  Future<Response> updateUser(int id, User user) {
    return put('$baseUrl/users/$id', user.toJson());
  }
}
