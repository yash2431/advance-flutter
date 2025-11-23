import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'lab_19_2_1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController()); // Inject AuthController
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sign-In Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign-In with GetX")),
      body: Center(
        child: Obx(() {
          if (authController.user.value != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      authController.user.value?.photoURL ?? ""),
                  radius: 40,
                ),
                const SizedBox(height: 10),
                Text("Hello, ${authController.user.value?.displayName}"),
                Text("${authController.user.value?.email}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authController.signOut,
                  child: const Text("Sign Out"),
                ),
              ],
            );
          } else {
            return ElevatedButton(
              onPressed: authController.signInWithGoogle,
              child: const Text("Sign in with Google"),
            );
          }
        }),
      ),
    );
  }
}
