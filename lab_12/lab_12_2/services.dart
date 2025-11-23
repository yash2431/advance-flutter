// lib/services/api_service.dart
import 'package:get/get.dart';

class ApiService extends GetConnect {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<Response> deleteUser(int id) async {
    return delete('$baseUrl/users/$id');
  }
}
