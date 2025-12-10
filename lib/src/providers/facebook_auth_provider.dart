import 'package:auth_ninja_sdk/src/core/auth_ninja_exceptions.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthProvider {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FacebookAuth _facebookAuth;

  FacebookAuthProvider({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FacebookAuth? facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  Future<AuthState> signIn() async {
    try {
      final LoginResult result = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.cancelled) {
        throw FacebookSignInCancelledException();
      }

      if (result.status == LoginStatus.failed) {
        throw FacebookSignInFailedException(result.message);
      }

      final accessToken = result.accessToken;
      if (accessToken == null) {
        throw FacebookAccessTokenException();
      }

      final credential = firebase_auth.FacebookAuthProvider.credential(
        accessToken.token,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user!;

      return AuthState.authenticated(
        userId: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleFirebaseError(e);
    } on AuthNinjaException {
      rethrow;
    } catch (e) {
      throw AuthExceptionHandler.handleFacebookError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _facebookAuth.logOut();
    } catch (e) {
      throw AuthExceptionHandler.handleFacebookError(e);
    }
  }

  /// Get current Facebook access token
  Future<AccessToken?> getAccessToken() async {
    try {
      return await _facebookAuth.accessToken;
    } catch (e) {
      return null;
    }
  }

  /// Get Facebook user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userData = await _facebookAuth.getUserData(
        fields: "name,email,picture.width(200)",
      );
      return userData;
    } catch (e) {
      return null;
    }
  }

  /// Check if user is currently logged in with Facebook
  Future<bool> isLoggedIn() async {
    final accessToken = await _facebookAuth.accessToken;
    return accessToken != null;
  }
}
