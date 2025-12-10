import 'package:auth_ninja_sdk/src/core/auth_ninja_exceptions.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthProvider {
 // static const String _webClientId = '18554660222-avvlcrt6l52d671nbaltq9moat54ltmp.apps.googleusercontent.com';
  
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  GoogleAuthProvider({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(
          scopes: ['email'],
          //serverClientId: _webClientId,
        );

  Future<AuthState> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw GoogleSignInCancelledException();
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
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
      throw AuthExceptionHandler.handleGoogleError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      throw AuthExceptionHandler.handleGoogleError(e);
    }
  }
}
