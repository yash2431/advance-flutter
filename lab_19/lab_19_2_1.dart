import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;

      // Initialize if required
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
        "Hello, ${FirebaseAuth.instance.currentUser?.displayName}",
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}
