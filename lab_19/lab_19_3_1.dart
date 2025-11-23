import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  /// ✅ Google Sign-In and Save to Firestore
  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      GoogleSignInAccount? account;
      if (googleSignIn.supportsAuthenticate()) {
        account = await googleSignIn.authenticate();
      } else {
        account = await googleSignIn.attemptLightweightAuthentication();
      }

      if (account == null) {
        Get.snackbar("Cancelled", "User cancelled the sign-in.");
        return;
      }

      final googleAuth = await account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar(
        "Signed In",
        "Welcome, ${FirebaseAuth.instance.currentUser?.displayName}",
      );

      // ✅ Sign in with Firebase
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // ✅ Save to Firestore
        await _firestore.collection("users").doc(firebaseUser.uid).set({
          "uid": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "email": firebaseUser.email,
          "photoUrl": firebaseUser.photoURL,
          "lastLogin": DateTime.now(),
        }, SetOptions(merge: true));

        Get.snackbar("Success", "Welcome, ${firebaseUser.displayName}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// ✅ Sign Out
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}
