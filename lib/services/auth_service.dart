import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  // Use a getter to avoid calling FirebaseAuth.instance before initialization
  FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      debugPrint("FirebaseAuth.instance accessed before initialization or failed: $e");
      rethrow;
    }
  }

  // Current User
  User? get currentUser {
    try {
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }

  // Auth State Changes
  Stream<User?> get authStateChanges {
    try {
      return _auth.authStateChanges();
    } catch (e) {
      return const Stream.empty();
    }
  }

  // Register User
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  // Login User
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // Send Password Reset Email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Password reset failed: $e");
    }
  }

  // Logout User
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    try {
      await currentUser?.delete();
    } catch (e) {
      throw Exception("Account deletion failed: $e");
    }
  }
}
