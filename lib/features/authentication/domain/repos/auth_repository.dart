import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get authUser;
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> registerWithEmailAndPassword(String email, String password);
  Future<void> sendEmailVerification();
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<UserCredential?> signInWithGoogle();
  Future<void> logout();
  Future<void> deleteAccount();
}
