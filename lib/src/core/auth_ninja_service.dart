import 'package:auth_ninja_sdk/src/providers/apple_auth_provider.dart';
import 'package:auth_ninja_sdk/src/providers/email_auth_provider.dart';
import 'package:auth_ninja_sdk/src/providers/facebook_auth_provider.dart';
import 'package:auth_ninja_sdk/src/providers/google_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'auth_ninja_state.dart';

/*
THIS CLASS EXPOSES THE PROVIDERS TO OUR AUTH_REPO MAPPING THE OUR AUTH_STATE
 */
class AuthNinjaService {
  final firebase.FirebaseAuth _firebaseAuth;
  final EmailAuthProvider _emailProvider;
  final GoogleAuthProvider _googleProvider;
  final AppleAuthProvider _appleProvider;
  final FacebookAuthProvider _facebookProvider;

  AuthNinjaService({
    firebase.FirebaseAuth? firebaseAuth,
    EmailAuthProvider? emailProvider,
    GoogleAuthProvider? googleProvider,
    AppleAuthProvider? appleProvider,
    FacebookAuthProvider? facebookProvider,
  })  : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance,
        _emailProvider = emailProvider ?? EmailAuthProvider(),
        _googleProvider = googleProvider ?? GoogleAuthProvider(),
        _appleProvider = appleProvider ?? AppleAuthProvider(),
        _facebookProvider = facebookProvider ?? FacebookAuthProvider();

  Stream<AuthState> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return AuthState.unauthenticated();
      }
      return AuthState.authenticated(
        userId: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
    });
  }

  //USE CREDENTIALS AND STATUS
  firebase.User? get currentUser => _firebaseAuth.currentUser;

  // EMAIL AND PASSWORD AUTHENTICATION SERVICES THAT CONNECTS TO THE PROVIDER
  Future<AuthState> signInWithEmail(String email, String password) async {
    return await _emailProvider.signIn(email, password);
  }

  Future<AuthState> signUpWithEmail(String email, String password,
      {String? displayName}) async {
    return await _emailProvider.signUp(email, password,
        displayName: displayName);
  }

  Future<void> resetPassword(String email) async {
    await _emailProvider.resetPassword(email);
  }

  // GOOGLE SIGN IN SERVICES THAT CONNECTS TO THE SIGN IN WITH GOOGLE PROVIDER
  Future<AuthState> signInWithGoogle() async {
    return await _googleProvider.signIn();
  }

  // APPLE SIGN IN SERVICES THAT CONNECTS TO THE SIGN IN WITH APPLE PROVIDER
  Future<AuthState> signInWithApple() async {
    return await _appleProvider.signIn();
  }

  // FACEBOOK SIGN IN SERVICES THAT CONNECTS TO THE SIGN IN WITH FACEBOOK PROVIDER
  Future<AuthState> signInWithFacebook() async {
    return await _facebookProvider.signIn();
  }

  //GENERAL SERVICES FOR THE AUTH NINJA SDK
  Future<void> signOut() async {
    //Apple and Email & Password providers sign out through firebase.
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    final providerId = user.providerData.first.providerId;

    if (providerId == 'google.com') {
      await _googleProvider.signOut();
    } else if (providerId == 'facebook.com') {
      await _facebookProvider.signOut();
    }

    await _firebaseAuth.signOut();
  }

  Future<bool> isTokenExpired() async {
    final user = currentUser;
    if (user == null) return true;

    try {
      final idTokenResult = await user.getIdTokenResult();
      final expirationTime = idTokenResult.expirationTime;

      if (expirationTime == null) return false;

      return DateTime.now().isAfter(expirationTime);
    } catch (e) {
      return true;
    }
  }

  Future<void> refreshToken() async {
    final user = currentUser;
    if (user != null) {
      await user.getIdToken(true);
    }
  }

  String? get currentProviderId {
    final user = currentUser;
    if (user == null || user.providerData.isEmpty) return null;
    return user.providerData.first.providerId;
  }

  bool isSignedInWith(String providerId) {
    return currentProviderId == providerId;
  }
}
