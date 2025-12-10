import 'package:auth_ninja_sdk/src/core/auth_ninja_exceptions.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthProvider {
  final FirebaseAuth _firebaseAuth;

  EmailAuthProvider({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<AuthState> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      return AuthState.authenticated(
        userId: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleFirebaseError(e);
    } on AuthNinjaException {
      rethrow;
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  Future<AuthState> signUp(
    String email,
    String password, {
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      if (displayName != null) {
        await user.updateDisplayName(displayName);
        await user.reload();
      }

      return AuthState.authenticated(
        userId: user.uid,
        email: user.email,
        displayName: displayName ?? user.displayName,
        photoUrl: user.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleFirebaseError(e);
    } on AuthNinjaException {
      rethrow;
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleFirebaseError(e);
    } on AuthNinjaException {
      rethrow;
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }
}
