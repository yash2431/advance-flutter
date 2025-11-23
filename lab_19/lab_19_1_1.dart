import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseBinding extends Bindings {
  @override
  void dependencies() async {
    await Firebase.initializeApp();
  }
}
