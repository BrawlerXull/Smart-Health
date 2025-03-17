import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  /// ✅ Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();

      if (GetPlatform.isWeb) {
        await _auth.signInWithPopup(googleProvider);
        Get.offAllNamed(Routes.HOME);
      } else {
        await _auth.signInWithProvider(googleProvider);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In failed: $e");
      if (kDebugMode) print("Error while sign in: $e");
    }
  }

  /// ✅ Email & Password Sign-In
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", "Sign-In failed: $e");
      if (kDebugMode) print("Error while sign in: $e");
    }
  }

  /// ✅ Email Registration
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", "Registration failed: $e");
      if (kDebugMode) print("Error while registration: $e");
    }
  }

  /// ✅ Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
