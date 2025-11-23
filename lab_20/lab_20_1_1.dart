import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  // Create
  Future<void> addUser(String name, int age) async {
    await users.add({
      'name': name,
      'age': age,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Read (Stream for real-time updates)
  Stream<QuerySnapshot> getUsers() {
    return users.orderBy('createdAt', descending: true).snapshots();
  }

  // Update
  Future<void> updateUser(String docId, String name, int age) async {
    await users.doc(docId).update({
      'name': name,
      'age': age,
    });
  }

  // Delete
  Future<void> deleteUser(String docId) async {
    await users.doc(docId).delete();
  }
}
