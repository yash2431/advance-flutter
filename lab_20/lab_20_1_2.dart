import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lab_20_1_1.dart';

class UserController extends GetxController {
  final FirestoreService _service = FirestoreService();

  Stream<QuerySnapshot> get usersStream => _service.getUsers();

  Future<void> addUser(String name, int age) => _service.addUser(name, age);

  Future<void> updateUser(String id, String name, int age) =>
      _service.updateUser(id, name, age);

  Future<void> deleteUser(String id) => _service.deleteUser(id);
}
