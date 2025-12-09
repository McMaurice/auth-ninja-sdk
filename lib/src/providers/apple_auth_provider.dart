import 'package:auth_ninja_sdk/src/core/auth_ninja_exceptions.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthProvider {
  final FirebaseAuth _firebaseAuth;

  AppleAuthProvider({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<AuthState> signIn() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      final user = userCredential.user!;

      return AuthState.authenticated(
        userId: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleFirebaseError(e);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw AppleSignInCancelledException();
      } else {
        throw AppleSignInFailedException(e.message);
      }
    } on AuthNinjaException {
      rethrow;
    } catch (e) {
      throw AuthExceptionHandler.handleAppleError(e);
    }
  }
}
